import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safeguide/api/consts.dart';
import 'package:safeguide/api/mutations.dart';
import 'package:safeguide/api/queries.dart';
import 'package:safeguide/api/supabase.dart';
import 'package:safeguide/components/cards.dart';
import 'package:safeguide/const/types.dart';
import 'package:safeguide/const/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:safeguide/components/buttons.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ReportIncident extends StatefulWidget {
  @override
  _ReportIncidentState createState() => _ReportIncidentState();
}

class _ReportIncidentState extends State<ReportIncident> {
  String? _selectedCategory;
  Incident? _selectedIncident;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  late Future<LatLng> _currentLocation;
  List<Incident> _incidents = [];

  late var _idUser = "";

  Future<void> setUserId() async {
    var id = await getCurrentUser();
    setState(() {
      _idUser = id!;
      print(_idUser);
    });
  }

  @override
  void initState() {
    super.initState();
    setUserId();
    _currentLocation = _getCurrentLocation();
    _fetchIncidents();
  }

  Future<LatLng> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onMapTapped(LatLng position) async {
    LatLng currentLocation = await _currentLocation;
    double distanceInMeters = Geolocator.distanceBetween(
      currentLocation.latitude,
      currentLocation.longitude,
      position.latitude,
      position.longitude,
    );

    if (distanceInMeters <= 402.00) {
      setState(() {
        HapticFeedback.mediumImpact();
        _markers.clear();
        _markers.add(Marker(
          markerId: MarkerId(position.toString()),
          position: position,
        ));
      });
    }
  }

  void submitForm(RunMutation runMutation) async {
    print(_markers.first.position.latitude);
    print(_markers.first.position.longitude);
    print(_selectedIncident!.id);
    print(DateTime.now().toUtc());
    print(_idUser);
    HapticFeedback.mediumImpact();
    runMutation({
      "lat": _markers.first.position.latitude.toString(),
      "long": _markers.first.position.longitude.toString(),
      "userId": _idUser,
      "incidenceTypeId": _selectedIncident!.id.toString(),
      "date": DateTime.now().toUtc().toIso8601String()
    });
  }

  void _fetchIncidents() async {
    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      ),
    );

    final QueryOptions options = QueryOptions(
      document: gql(getIncidenceTypeList),
    );

    final QueryResult result = await client.value.query(options);

    if (result.hasException) {
      print(result.exception);
      return;
    }

    final List incidentsData = result.data?['getIncidenceTypeList'] ?? [];

    setState(() {
      _incidents = incidentsData.map((incidentData) {
        return Incident(
          incidentData['name'],
          getIconForIncident(incidentData['name']),
          incidentData['id'],
          incidentData['description'],
          incidentData['category'],
        );
      }).toList();
    });
  }

  void _selectIncident(Incident incident) {
    setState(() {
      _selectedIncident = incident;
    });
    HapticFeedback.mediumImpact();
  }

  void _deselectIncident() {
    print('Deselecting incident');
    setState(() {
      _selectedIncident = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql(createIncident),
        update: (GraphQLDataProxy cache, QueryResult? result) async {},
        onError: (OperationException? error) async {
          print("Error ");
          print(error);
        },
        onCompleted: (dynamic resultData) {
          print("Completed");
          print(resultData);
          Navigator.pop(context);
          Navigator.pushNamed(context, '/reportSuccess');
        },
      ),
      builder: (RunMutation runMutation, QueryResult? result) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon:
                  const Icon(Icons.chevron_left, color: Colors.black, size: 35),
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Report incident',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          body: _selectedIncident == null
              ? _selectedCategory == null
                  ? CategoryLister(
                      categoriesData: _incidents
                          .map((incident) => incident.category)
                          .toSet()
                          .toList(),
                      selectCategory: (String category) {
                        setState(() {
                          _selectedCategory = category;
                        });
                        print(_selectedCategory);
                      },
                    )
                  : IncidentLister(
                      incidentsData: _incidents
                          .where((incident) =>
                              incident.category == _selectedCategory)
                          .toList(),
                      selectIncident: _selectIncident,
                      deselectCategory: () {
                        setState(() {
                          _selectedCategory = null;
                        });
                      },
                    )
              : IncidentMarker(
                  selectedIncident: _selectedIncident!,
                  deselectIncident: _deselectIncident,
                  currentLocation: _currentLocation,
                  onMapCreated: _onMapCreated,
                  onMapTapped: _onMapTapped,
                  markers: _markers,
                  submitIncident: submitForm,
                  mutation: runMutation,
                ),
        );
      },
    );
  }
}

class IncidentLister extends StatefulWidget {
  const IncidentLister(
      {super.key,
      required this.incidentsData,
      required this.selectIncident,
      required this.deselectCategory // And this});
      });

  final List incidentsData;
  final selectIncident;
  final Function deselectCategory;

  @override
  State<IncidentLister> createState() => _IncidentListerState();
}

class _IncidentListerState extends State<IncidentLister> {
  final TextEditingController _filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2.3,
                    children: widget.incidentsData.map((incident) {
                      return GestureDetector(
                        onTap: () => widget.selectIncident(incident),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  getIconForIncident(incident.name),
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    incident.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )),
            ),
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                widget.deselectCategory();
              },
              child: Container(
                padding: EdgeInsets.only(top: 3.h),
                height: 12.h,
                child: Text("Back to categories",
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ));
  }
}

class CategoryLister extends StatefulWidget {
  final List<String> categoriesData;
  final Function(String) selectCategory;

  CategoryLister({
    required this.categoriesData,
    required this.selectCategory,
  });

  @override
  _CategoryListerState createState() => _CategoryListerState();
}

class _CategoryListerState extends State<CategoryLister> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.3,
      ),
      itemCount: widget.categoriesData.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => widget.selectCategory(widget.categoriesData[index]),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color:
                        Colors.red, // Change color according to your preference
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    getIconForCategory(widget.categoriesData[index]),
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      spaceByUpper(widget.categoriesData[index]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class IncidentMarker extends StatefulWidget {
  const IncidentMarker(
      {super.key,
      required this.currentLocation,
      required this.markers,
      required this.onMapCreated,
      required this.onMapTapped,
      required this.selectedIncident,
      required this.deselectIncident,
      required this.submitIncident,
      required this.mutation});
  final currentLocation;
  final markers;
  final onMapCreated;
  final onMapTapped;
  final selectedIncident;
  final deselectIncident;
  final submitIncident;
  final mutation;
  @override
  State<IncidentMarker> createState() => _IncidentMarkerState();
}

class _IncidentMarkerState extends State<IncidentMarker> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Expanded(
          child: Container(
        child: FutureBuilder<LatLng>(
          future: widget.currentLocation,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              LatLng? target = snapshot.data;
              if (target != null) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(target.latitude + 0.0003, target.longitude),
                    zoom: 19.0,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: widget.onMapCreated,
                  onTap: widget.onMapTapped,
                  markers: widget.markers,
                );
              }
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      )),
      if (widget.selectedIncident != null)
        Positioned(
          top: 15.h,
          child: IncidentDetails(
            incident: widget.selectedIncident!,
            onBack: () {
              widget.deselectIncident();
            },
          ),
        ),
      if (widget.selectedIncident != null && widget.markers.isEmpty)
        Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: 100.w,
              child: Center(
                child: Text(
                  'Tap on the map to select the location of the incident.',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )),
      if (widget.selectedIncident != null && widget.markers.isNotEmpty)
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: 100.w,
            child: Center(
              child: Button(
                onPressed: () {
                  widget.submitIncident(widget.mutation);
                },
                title: 'Submit report',
              ),
            ),
          ),
        ),
    ]);
  }
}

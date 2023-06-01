import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safeguide/api/consts.dart';
import 'package:safeguide/api/queries.dart';
import 'package:safeguide/components/cards.dart';
import 'package:safeguide/const/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:safeguide/components/buttons.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ReportIncident extends StatefulWidget {
  @override
  _ReportIncidentState createState() => _ReportIncidentState();
}

class _ReportIncidentState extends State<ReportIncident> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  late Future<LatLng> _currentLocation;
  bool _showSubmitButton = false;
  List<Incident> _incidents = [];
  Incident? _selectedIncident;

  @override
  void initState() {
    super.initState();
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

  void _onSubmitPressed() {
    if (_selectedIncident != null && _markers.isNotEmpty) {
      print('Incident Type: ${_selectedIncident!.name}');
      print('Latitude: ${_markers.first.position.latitude}');
      print('Longitude: ${_markers.first.position.longitude}');
      Navigator.pop(context);
      Navigator.pushNamed(context, '/reportSuccess');
    }
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
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 35),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Report incident',
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Stack(children: <Widget>[
        Container(
          height: 100.h,
          child: FutureBuilder<LatLng>(
            future: _currentLocation,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                LatLng? target = snapshot.data;
                if (target != null) {
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target:
                          LatLng(target.latitude + 0.0003, target.longitude),
                      zoom: 19.0,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: _onMapCreated,
                    onTap: _onMapTapped,
                    markers: _markers,
                  );
                }
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        Positioned(
            top: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: 100.w,
              height: 51.h,
              child: _selectedIncident == null
                  ? GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 2.3,
                      children: _incidents.map((incident) {
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            setState(() {
                              _selectedIncident = incident;
                            });
                          },
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
                                    incident.icon,
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
                    )
                  : IncidentDetails(
                      incident: _selectedIncident!,
                      onBack: () {
                        setState(() {
                          _selectedIncident = null;
                        });
                      },
                    ),
            )),
        if (_selectedIncident != null && _markers.isEmpty)
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
        if (_selectedIncident != null && _markers.isNotEmpty)
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
                    HapticFeedback.heavyImpact();
                    _onSubmitPressed();
                  },
                  title: 'Submit report',
                ),
              ),
            ),
          ),
      ]),
    );
  }
}

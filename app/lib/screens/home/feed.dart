import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safeguide/api/queries.dart';
import 'package:safeguide/const/utils.dart';
import 'package:safeguide/screens/home/incidentScreen.dart';
import 'package:sizer/sizer.dart';

class FeedView extends StatefulWidget {
  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  Future<String> _locationData = Future.value('Getting current location...');
  List<String> categories = [
    'All',
    'Theft',
    'Violence',
    'ThreateningPerson',
    'SuspiciousActivity',
    'Hazard',
    'EmergencyResponder',
    'GeneralIncident',
    'Other'
  ];
  String selectedCategory = 'All';

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        setState(() {
          _locationData = Future.value(
              '${placemark.name}, ${placemark.subLocality}, ${placemark.locality}');
        });
      } else {
        setState(() {
          _locationData = Future.value('Location not found');
        });
      }
    } catch (e) {
      setState(() {
        _locationData = Future.value('Error: ${e.toString()}');
      });
    }
  }

  Future<String> _getLocationData(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude,
          localeIdentifier: 'en');

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return '${placemark.name}, ${placemark.subLocality}, ${placemark.locality}';
      }

      return '';
    } catch (e) {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Icon(Icons.location_pin, color: Colors.red, size: 30),
                const SizedBox(width: 4),
                Expanded(
                  child: FutureBuilder<String>(
                    future: _locationData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return const Text(
                          'Getting current location...',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 20),
              ]),
              Divider(),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: 4.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext builder) {
                          return Container(
                            height: 30.h,
                            child: CupertinoPicker(
                              itemExtent: 30,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  selectedCategory = categories[index];
                                });
                              },
                              children: List<Widget>.generate(
                                categories.length,
                                (int index) {
                                  return Text(categories[index]);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      'Display: $selectedCategory Incidents',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
                child: Container(
                    child: Query(
              options: QueryOptions(
                document: gql(getAllIncidencesQuery),
              ),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }

                if (result.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                List incidents = result.data!['getAllIncidences'];

                List filteredIncidents = incidents.where((incident) {
                  return selectedCategory == 'All' ||
                      incident['incidenceType']['category'] == selectedCategory;
                }).toList();

                return RefreshIndicator(
                    onRefresh: () async {
                      refetch!();
                    },
                    child: ListView.builder(
                      itemCount: filteredIncidents.length,
                      itemBuilder: (context, index) {
                        final incident = filteredIncidents[index];
                        final incidentName = incident['incidenceType']['name'];
                        final incidentIcon = getIconForIncident(incidentName);
                        final date = incident['date'];
                        final text = incident['incidenceType']['description'];
                        final source = 'Unknown';
                        final latLng = LatLng(double.parse(incident['lat']),
                            double.parse(incident['long']));

                        return FutureBuilder<String>(
                          future: _getLocationData(latLng),
                          builder: (context, snapshot) {
                            String locationData = snapshot.data ?? '';
                            return GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IncidentDetailsScreen(
                                      title: incidentName,
                                      icon: incidentIcon,
                                      date: date,
                                      location: locationData,
                                      text: text,
                                      source: source,
                                      latLng: latLng,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Card(
                                  child: ListTile(
                                    leading: Icon(incidentIcon,
                                        color: Colors.red, size: 30),
                                    title: Text(
                                      incidentName,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 4),
                                        Text(convertToLocalTime(date),
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10)),
                                        const SizedBox(height: 4),
                                        Text(locationData,
                                            style:
                                                const TextStyle(fontSize: 12)),
                                        const SizedBox(height: 4),
                                        Text(text,
                                            style: const TextStyle(
                                                fontSize: 14, height: 1.2)),
                                        const SizedBox(height: 4),
                                        Text('Source: $source',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 4),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ));
              },
            )))
          ],
        ));
  }
}

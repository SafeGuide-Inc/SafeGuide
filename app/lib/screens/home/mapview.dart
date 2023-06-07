import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safeguide/components/buttons.dart';
import 'package:safeguide/components/cardSlider.dart';
import 'package:safeguide/const/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  bool _showDetails = false;
  List<Map<String, dynamic>> cards = [];
  List<Marker> _markers = [];
  bool _didInitializeMarkers = false;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(44.0463209, -123.077315), zoom: 15.35);

  Future<void> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isPermanentlyDenied) {
      _requestLocationPermission();
    } else if (status.isDenied) {
      _requestLocationPermission();
    } else if (status.isGranted) {}
  }

  Future<void> _showPermanentlyDeniedDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Required'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This app requires location permission to function.'),
                Text('Please grant location permission in the app settings.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _initializeMarkers() async {
    final QueryOptions options = QueryOptions(
      document: gql('''
        query GetAllIncidences {
          getAllIncidences {
            date
            existsVotes
            id
            lat
            long
            userId
            incidenceType {
              category
              description
              id
              name
            }
          }
        }
      '''),
    );

    final GraphQLClient client = GraphQLProvider.of(context).value;
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return;
    }

    final incidents = result.data?['getAllIncidences'];
    for (var incident in incidents) {
      cards.add({
        'icon': getIconForIncident(incident['incidenceType']['name']),
        'title': incident['incidenceType']['name'],
        'date': incident['date'],
        'text': incident['incidenceType']['description'],
        'latLng': LatLng(
            double.parse(incident['lat']), double.parse(incident['long'])),
      });
    }

    for (int i = 0; i < cards.length; i++) {
      Marker marker = Marker(
        markerId: MarkerId(cards[i]['latLng'].toString()),
        position: cards[i]['latLng'],
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
      _markers.add(marker);
    }

    setState(() {}); // Update the state after fetching data.
  }

  Future<void> _goToCardLocation(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 15.35)));
  }

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didInitializeMarkers) {
      _initializeMarkers();
      _didInitializeMarkers = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            bottom: 13.h,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 15.h,
              child:
                  CardSlider(cards: cards, goToCardLocation: _goToCardLocation),
            ),
          ),
          Positioned(top: 15.h, right: 5.w, child: const EmergencyButton())
        ],
      ),
    );
  }
}

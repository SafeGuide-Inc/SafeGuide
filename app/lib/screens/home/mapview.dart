import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safeguide/components/buttons.dart';
import 'package:safeguide/components/cardSlider.dart';
import 'package:sizer/sizer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(44.0463209, -123.077315), zoom: 15.35);

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _initializeMarkers();
  }

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

  List<Map<String, dynamic>> cards = [
    {
      'icon': FontAwesomeIcons.mask,
      'title': 'Theft',
      'date': '01/18/2021 12:00 PM',
      'text':
          'An individual or individuals unlawfully took possession of property that did not belong to them',
      'latLng': LatLng(44.0463209, -123.077315),
    },
    {
      'icon': FontAwesomeIcons.pills,
      'title': 'Drug Activity',
      'date': '01/18/2021 12:00 PM',
      'text': 'Lorem Ipsun Dolor Sit Amet',
      'latLng': LatLng(44.0563209, -123.077315),
    },
    {
      'icon': FontAwesomeIcons.gun,
      'title': 'Sketchy Person',
      'date': '01/18/2021 12:00 PM',
      'text': 'Lorem Ipsun Dolor Sit Amet',
      'latLng': LatLng(44.0463209, -123.087315),
    },
  ];

  List<Marker> _markers = [];

  void _initializeMarkers() {
    for (int i = 0; i < cards.length; i++) {
      Marker marker = Marker(
        markerId: MarkerId(cards[i]['latLng'].toString()),
        position: cards[i]['latLng'],
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
      _markers.add(marker);
    }
  }

  Future<void> _goToCardLocation(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 15.35)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      GoogleMap(
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          }),
      Positioned(
          bottom: 13.h,
          left: 0,
          right: 0,
          child: SizedBox(
              height: 15.h,
              child: CardSlider(
                  cards: cards, goToCardLocation: _goToCardLocation))),
      Positioned(top: 15.h, right: 5.w, child: const EmergencyButton())
    ]));
  }
}

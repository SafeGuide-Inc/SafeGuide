import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safeguide/components/buttons.dart';
import 'package:safeguide/components/cardSlider.dart';
import 'package:sizer/sizer.dart';

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

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(44.0463209, -123.077315),
      tilt: 59.440717697143555,
      zoom: 15.35);

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      GoogleMap(
          myLocationButtonEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          }),
      Positioned(
        top: 15.h,
        left: 0,
        right: 0,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[SizedBox(child: ToggleButton())]),
      ),
      Positioned(
          bottom: 15.h,
          left: 0,
          right: 0,
          child: SizedBox(
              height: 12.h,
              child: CardSlider(
                cards: const [
                  {
                    'icon': FontAwesomeIcons.mask,
                    'title': 'Theft',
                    'date': '01/18/2021 12:00 PM',
                    'text': 'Lorem Ipsun Dolor Sit Amet',
                  },
                  {
                    'icon': FontAwesomeIcons.pills,
                    'title': 'Drug Activity',
                    'date': '01/18/2021 12:00 PM',
                    'text': 'Lorem Ipsun Dolor Sit Amet',
                  },
                  {
                    'icon': FontAwesomeIcons.gun,
                    'title': 'sketchy person',
                    'date': '01/18/2021 12:00 PM',
                    'text': 'Lorem Ipsun Dolor Sit Amet',
                  },
                ],
              )))
    ]));
  }
}

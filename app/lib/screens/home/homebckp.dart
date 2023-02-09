import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safeguide/components/navbar.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/cardSlider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MapSample();
  }
}

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(44.0463209, -123.077315), zoom: 15.35);

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(44.0463209, -123.077315),
      tilt: 59.440717697143555,
      zoom: 15.35);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBottomNavBar(),
        extendBody: true,
        body: Stack(children: <Widget>[
          GoogleMap(
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                  height: 110,
                  child: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.white.withOpacity(0.75),
                      centerTitle: true,
                      automaticallyImplyLeading: false,
                      title: SizedBox(
                        height: 5.h,
                        child: Image.asset("assets/images/logo.png"),
                      )))),
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

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

class ToggleButton extends StatefulWidget {
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool _selectedOption = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ToggleButtons(
        fillColor: _selectedOption ? Colors.red : Colors.white,
        selectedColor: _selectedOption ? Colors.red : Colors.red,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        onPressed: (int index) {
          setState(() {
            for (int buttonIndex = 0; buttonIndex < 2; buttonIndex++) {
              if (buttonIndex == index) {
                _selectedOption = !_selectedOption;
              }
            }
          });
        },
        isSelected: _selectedOption ? [true, false] : [false, true],
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Map View",
              style: _selectedOption
                  ? const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)
                  : const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Feed View",
              style: _selectedOption
                  ? const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal)
                  : const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

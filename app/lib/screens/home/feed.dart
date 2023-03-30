import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safeguide/screens/home/incidentScreen.dart';
import 'package:sizer/sizer.dart';

class FeedView extends StatefulWidget {
  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  Future<String> _locationData = Future.value('Getting current location...');

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

  final List<Widget> _incidentCards = <Widget>[];

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

    // Create the incident cards.
    Future.wait(cards.map((card) async {
      final incidentName = card['title'];
      final incidentIcon = card['icon'];
      final date = card['date'];
      final text = card['text'];
      final source = 'Unknown';
      final latLng = card['latLng'];

      final locationData = await _getLocationData(latLng);

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
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Card(
            child: ListTile(
              leading: Icon(incidentIcon, color: Colors.red, size: 30),
              title: Text(
                incidentName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(locationData ?? '', style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(date,
                      style: TextStyle(color: Colors.grey, fontSize: 10)),
                  const SizedBox(height: 4),
                  Text(text, style: TextStyle(fontSize: 14, height: 1.2)),
                  const SizedBox(height: 4),
                  Text('Source: $source',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
        ),
      );
    })).then((cards) {
      setState(() {
        _incidentCards.addAll(cards);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_pin, color: Colors.red, size: 30),
            const SizedBox(width: 4),
            Expanded(
              child: FutureBuilder<String>(
                future: _locationData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data!,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
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
          ],
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: _incidentCards,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReportIncidentScreen extends StatefulWidget {
  // Initialize the map controller
  late GoogleMapController mapController;

  // Set initial position of map
  final LatLng _initialPosition = LatLng(37.7749, -122.4194);

  // Create list of incident types
  final List<String> _incidentTypes = ['Accident', 'Thieft', 'None'];

  // Initialize selected incident type to None
  String _selectedType = 'None';

  // Create map of incident icons
  final Map<String, BitmapDescriptor> _incidentIcons = {
    'Accident': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    'Thieft':
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
    'Other': BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  };

  // Set initial position of marker to None
  LatLng? _markerPosition;

  // Create a method to handle the selection of an incident type
  void _selectType(String type) {}

  // Create a method to handle the placement of a marker on the map
  void _placeMarker(LatLng position) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Incident'),
      ),
      body: Column(
        children: [
          // Create row of incident type cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (String type in _incidentTypes)
                GestureDetector(
                  onTap: () => _selectType(type),
                  child: Card(
                    color: _selectedType == type ? Colors.blue : null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.0),
          // Create Google Map widget
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 13.0,
              ),
              onMapCreated: (controller) => mapController = controller,
              onTap: (position) => _placeMarker(position),
              markers: _markerPosition != null
                  ? {
                      Marker(
                        markerId: MarkerId('incident'),
                        position: _markerPosition!,
                        icon: _incidentIcons[_selectedType] ??
                            BitmapDescriptor.defaultMarker,
                      )
                    }
                  : {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

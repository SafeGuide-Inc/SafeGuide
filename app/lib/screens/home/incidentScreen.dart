import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class IncidentDetailsScreen extends StatefulWidget {
  final IconData icon;
  final String title;
  final String date;
  final String location;
  final String text;
  final String source;
  final LatLng latLng;

  const IncidentDetailsScreen({
    Key? key,
    required this.icon,
    required this.title,
    required this.date,
    required this.location,
    required this.text,
    required this.source,
    required this.latLng,
  }) : super(key: key);

  @override
  _IncidentDetailsScreenState createState() => _IncidentDetailsScreenState();
}

class _IncidentDetailsScreenState extends State<IncidentDetailsScreen> {
  bool _isReported = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.75),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 40),
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.pop(context);
          },
        ),
        title: SizedBox(
          height: 5.h,
          child: Image.asset("assets/images/logo.png"),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Add share functionality here
            },
            icon: Icon(Icons.share, color: Colors.black),
          ),
        ],
        elevation: 0,
      ),
      body: Stack(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    widget.latLng.latitude - 0.0005, widget.latLng.longitude),
                zoom: 18,
              ),
              markers: Set.of([
                Marker(position: widget.latLng, markerId: const MarkerId('')),
              ]),
              myLocationButtonEnabled: false,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Card(
              child: Container(
                height: 320,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(widget.icon, color: Colors.red),
                        const SizedBox(width: 10),
                        Text(widget.title,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(widget.location, style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 5),
                    Text(widget.date, style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 10),
                    Flexible(
                      child: Text(
                        widget.text,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Source: ${widget.source}',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    Expanded(
                        child: Container(
                      child: Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              setState(() {
                                _isReported = true;
                              });
                            },
                            child: Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  color: Colors.red,
                                  width: 2,
                                ),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  'Not There',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            setState(() {
                              _isReported = true;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Text(
                                'Still There',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

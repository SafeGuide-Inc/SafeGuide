import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safeguide/const/utils.dart';
import 'package:sizer/sizer.dart';

class CardSlider extends StatefulWidget {
  final List<Map<String, dynamic>> cards;
  final Function(LatLng) goToCardLocation;

  CardSlider({
    required this.cards,
    required this.goToCardLocation,
  });

  @override
  _CardSliderState createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.cards.length,
                onPageChanged: (index) {
                  HapticFeedback.mediumImpact();
                  setState(() {
                    currentIndex = index;
                  });
                  widget.goToCardLocation(widget.cards[index]['latLng']);
                },
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(
                        left: 13.w,
                        right: 13.w,
                      ),
                      child: GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            setState(() {
                              // _showDetails = true;
                            });
                          },
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(children: [
                                Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 50,
                                        child: Icon(
                                          widget.cards[index]['icon'],
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              widget.cards[index]['title'],
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 1),
                                            Text(
                                              convertToLocalTime(
                                                  widget.cards[index]['date']),
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              widget.cards[index]['text'],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                            ),
                          )));
                },
              ),
            ),
            Positioned(
                left: 3.w,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 5.h,
                  ),
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, -1),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, size: 20),
                    onPressed: currentIndex > 0
                        ? () {
                            _pageController.animateToPage(
                              currentIndex - 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                            HapticFeedback.mediumImpact();
                            setState(() {
                              currentIndex -= 1;
                            });
                            LatLng latLng =
                                widget.cards[currentIndex]['latLng'];
                            widget.goToCardLocation(latLng);
                            Marker marker = Marker(
                              markerId: MarkerId(latLng.toString()),
                              position: latLng,
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueRed),
                            );
                            setState(() {
                              widget.cards[currentIndex]['marker'] = marker;
                            });
                            print(widget.cards[currentIndex]);
                          }
                        : null,
                  ),
                )),
            Positioned(
                right: 3.w,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 5.h,
                  ),
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, -1),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward, size: 20),
                    onPressed: currentIndex < widget.cards.length - 1
                        ? () {
                            HapticFeedback.mediumImpact();
                            _pageController.animateToPage(
                              currentIndex + 1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                            setState(() {
                              currentIndex += 1;
                            });
                            LatLng latLng =
                                widget.cards[currentIndex]['latLng'];
                            widget.goToCardLocation(latLng);
                            Marker marker = Marker(
                              markerId: MarkerId(latLng.toString()),
                              position: latLng,
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueRed),
                            );
                            setState(() {
                              widget.cards[currentIndex]['marker'] = marker;
                            });
                            print(widget.cards[currentIndex]);
                          }
                        : null,
                  ),
                )),
          ],
        ),
      ),
    ]);
  }
}

class DisplayIncident extends StatefulWidget {
  const DisplayIncident(
      {super.key, required this.cards, required this.goToCardLocation});
  final List<Map<String, dynamic>> cards;
  final Function(LatLng) goToCardLocation;
  @override
  State<DisplayIncident> createState() => _DisplayIncidentState();
}

class _DisplayIncidentState extends State<DisplayIncident> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 0.h, left: 4.w, right: 4.w),
        height: 300,
        child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Icon(
                          widget.cards[currentIndex]['icon'],
                          color: Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(widget.cards[currentIndex]['title'],
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                      ]),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.close, size: 20),
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          setState(() {
                            // _showDetails = false; // hide detailed card view
                          });
                        },
                      ),
                    ],
                  ),
                  Text(widget.cards[currentIndex]['latLng'].toString(),
                      style: TextStyle(fontSize: 10)),
                  const SizedBox(height: 5),
                  Text(widget.cards[currentIndex]['date'],
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Text(
                      widget.cards[currentIndex]['text'],
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            setState(() {
                              var _isReported = true;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.red,
                                width: 2,
                              ),
                              color: Colors.white,
                            ),
                            child: const Center(
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
                      const SizedBox(width: 20),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          setState(() {
                            var _isReported = true;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.red,
                          ),
                          child: const Center(
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
            )));
  }
}

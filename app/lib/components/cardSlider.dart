import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:sizer/sizer.dart';

class CardSlider extends StatefulWidget {
  final List<Map<String, dynamic>> cards;

  CardSlider({required this.cards});

  @override
  _CardSliderState createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(left: 13.w, right: 13.w),
                        child: Card(
                            child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                  width: 50,
                                  child: Icon(
                                    widget.cards[index]['icon'],
                                    size: 40,
                                    color: Colors.red,
                                  )),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.cards[index]['title'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 1),
                                  Text(
                                    widget.cards[index]['date'],
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    widget.cards[index]['text'],
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        )));
                  },
                ),
              ),
              Positioned(
                  left: 3.w,
                  top: 32,
                  child: Container(
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
                            }
                          : null,
                    ),
                  )),
              Positioned(
                  right: 3.w,
                  top: 32,
                  child: Container(
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
                            }
                          : null,
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

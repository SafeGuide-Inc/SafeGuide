import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

class Button extends StatefulWidget {
  final String title;
  final Function()? onPressed;
  final bool isLoading;

  const Button(
      {super.key,
      this.title = 'Something',
      this.onPressed,
      this.isLoading = false});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 56,
        margin: const EdgeInsets.only(top: 12),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffFF5757),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              minimumSize: const Size.fromHeight(100), // NEW
            ),
            onPressed: widget.onPressed,
            child: widget.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ))
                : Text(
                    widget.title,
                    style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  )));
  }
}

class SocialButton extends StatefulWidget {
  const SocialButton({super.key});

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => {}, icon: Image.asset('assets/google.png'));
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
          HapticFeedback.lightImpact();
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

class NotificationButton extends StatelessWidget {
  final int notificationCount;
  final Function()? onPressed;

  NotificationButton({required this.notificationCount, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SizedBox(
          child: Stack(
        children: <Widget>[
          const FaIcon(FontAwesomeIcons.bell, size: 26),
          notificationCount > 0
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      )),
      onPressed: () {
        HapticFeedback.lightImpact();
        onPressed!();
        // Add your button action here
      },
    );
  }
}

class EmergencyButton extends StatefulWidget {
  const EmergencyButton({super.key});

  @override
  State<EmergencyButton> createState() => _EmergencyButtonState();
}

class _EmergencyButtonState extends State<EmergencyButton> {
  int pressCount = 0;
  Timer? resetTimer;

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.8),
      textColor: Colors.white,
    );
  }

  void startEmergencyCall() async {
    HapticFeedback.vibrate();
    showToast('Calling 911...');
    const number = '911'; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  void handleButtonPress() {
    pressCount++;

    if (pressCount == 1) {
      showToast('Press 2 more times to call 911');
      HapticFeedback.mediumImpact();
      // Reset the press count after 2 seconds
      resetTimer = Timer(Duration(seconds: 2), () {
        setState(() {
          pressCount = 0;
        });
      });
    } else if (pressCount == 2) {
      HapticFeedback.heavyImpact();
      showToast('Press 1 more time to call 911');

      // Reset the press count after 2 seconds
      resetTimer?.cancel();
      resetTimer = Timer(Duration(seconds: 2), () {
        setState(() {
          pressCount = 0;
        });
      });
    } else if (pressCount >= 3) {
      // Reset the press count and cancel the reset timer
      resetTimer?.cancel();
      setState(() {
        pressCount = 0;
      });

      startEmergencyCall();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => handleButtonPress(),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.phone, size: 20, color: Colors.white),
              SizedBox(height: 4),
              Text('SOS',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ],
          )),
        ));
  }
}

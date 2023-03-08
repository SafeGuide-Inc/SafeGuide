import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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

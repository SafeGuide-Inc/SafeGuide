import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safeguide/components/buttons.dart';
import 'package:sizer/sizer.dart';

class CustomBottomNavBar extends StatefulWidget {
  CustomBottomNavBar({super.key, this.viewChangeFunction, required this.index});

  var viewChangeFunction;
  int index;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25, left: 12, right: 12),
      height: 60,
      width: 90.w,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -1),
            blurRadius: 6,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: FaIcon(FontAwesomeIcons.mapLocationDot,
                  color: widget.index == 0 ? Colors.red : Colors.black),
              onPressed: () {
                HapticFeedback.lightImpact();
                widget.viewChangeFunction(0);
              },
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.list,
                  color: widget.index == 1 ? Colors.red : Colors.black),
              onPressed: () {
                HapticFeedback.lightImpact();
                widget.viewChangeFunction(1);
              },
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 0),
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: IconButton(
                icon: const FaIcon(FontAwesomeIcons.exclamation),
                color: Colors.white,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Navigator.pushNamed(context, '/report');
                },
              ),
            ),
            NotificationButton(
              notificationCount: 2,
              onPressed: () {
                widget.viewChangeFunction(2);
              },
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.user,
                  color: widget.index == 3 ? Colors.red : Colors.black),
              onPressed: () {
                HapticFeedback.lightImpact();
                widget.viewChangeFunction(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}

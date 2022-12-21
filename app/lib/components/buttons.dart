import 'package:flutter/material.dart';
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

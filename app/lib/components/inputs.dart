import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class TextInput extends StatefulWidget {
  final String label;
  final String errorMessage;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool isPassword;

  const TextInput(
      {super.key,
      this.label = 'Something',
      this.errorMessage = '',
      this.keyboardType = TextInputType.text,
      this.controller,
      this.isPassword = false});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.label,
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xff79747E))),
        Container(
            margin: const EdgeInsets.only(top: 8, bottom: 4),
            child: TextField(
                controller: widget.controller,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () => {print('object')},
                      child: const Icon(Icons.clear, color: Color(0xff79747E)),
                    ),
                    prefixIcon:
                        const Icon(Icons.email, color: Color(0xff79747E)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Color(0xff79747E))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: const Color(0xffFFF)))),
        widget.errorMessage.isNotEmpty
            ? Text(widget.errorMessage,
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.red))
            : Container()
      ]),
    );
  }
}

class CodeInput extends StatefulWidget {
  @override
  _CodeInputState createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  FocusNode _firstDigitFocus = FocusNode();
  FocusNode _secondDigitFocus = FocusNode();
  FocusNode _thirdDigitFocus = FocusNode();
  FocusNode _fourthDigitFocus = FocusNode();
  FocusNode _fifthDigitFocus = FocusNode();
  FocusNode _sixthDigitFocus = FocusNode();

  TextEditingController _firstDigitController = TextEditingController();
  TextEditingController _secondDigitController = TextEditingController();
  TextEditingController _thirdDigitController = TextEditingController();
  TextEditingController _fourthDigitController = TextEditingController();
  TextEditingController _fifthDigitController = TextEditingController();
  TextEditingController _sixthDigitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 40,
              child: TextField(
                focusNode: _firstDigitFocus,
                controller: _firstDigitController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Color(0xff79747E))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: const Color(0xffFFFFFF)),
                onChanged: (text) {
                  if (text.length == 1) {
                    _firstDigitFocus.unfocus();
                    FocusScope.of(context).requestFocus(_secondDigitFocus);
                  }
                },
              ),
            ),
            SizedBox(
              width: 40,
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Color(0xff79747E))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: const Color(0xffFFFFFF)),
                focusNode: _secondDigitFocus,
                controller: _secondDigitController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.w400),
                onChanged: (text) {
                  if (text.length == 1) {
                    _secondDigitFocus.unfocus();
                    FocusScope.of(context).requestFocus(_thirdDigitFocus);
                  }
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 40,
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Color(0xff79747E))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: const Color(0xffFFFFFF)),
                focusNode: _thirdDigitFocus,
                controller: _thirdDigitController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.w400),
                onChanged: (text) {
                  if (text.length == 1) {
                    _thirdDigitFocus.unfocus();
                    FocusScope.of(context).requestFocus(_fourthDigitFocus);
                  }
                },
              ),
            ),
            SizedBox(
              width: 40,
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Color(0xff79747E))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: const Color(0xffFFFFFF)),
                focusNode: _fourthDigitFocus,
                controller: _fourthDigitController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.w400),
                onChanged: (text) {
                  if (text.length == 1) {
                    _fourthDigitFocus.unfocus();
                    FocusScope.of(context).requestFocus(_fifthDigitFocus);
                  }
                },
              ),
            ),
            SizedBox(
              width: 40,
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Color(0xff79747E))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: const Color(0xffFFFFFF)),
                focusNode: _fifthDigitFocus,
                controller: _fifthDigitController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.w400),
                onChanged: (text) {
                  if (text.length == 1) {
                    _fifthDigitFocus.unfocus();
                    FocusScope.of(context).requestFocus(_sixthDigitFocus);
                  }
                },
              ),
            ),
            SizedBox(
              width: 40,
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Color(0xff79747E))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: const Color(0xffFFFFFF)),
                focusNode: _sixthDigitFocus,
                controller: _sixthDigitController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.w400),
                onChanged: (text) {
                  if (text.length == 1) {
                    _sixthDigitFocus.unfocus();
                  }
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 3.h,
        ),
        SizedBox(
          child: InkWell(
            child: const Text(
              'Clear',
              style: TextStyle(
                fontSize: 16,
                color: Colors.redAccent,
              ),
            ),
            onTap: () {
              HapticFeedback.lightImpact();
              _firstDigitController.clear();
              _secondDigitController.clear();
              _thirdDigitController.clear();
              _fourthDigitController.clear();
              _fifthDigitController.clear();
              _sixthDigitController.clear();
              _firstDigitFocus.requestFocus();
            },
          ),
        ),
      ],
    );
  }
}

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
  final ValueChanged<String> onSubmitted;

  CodeInput(
      {required this.onSubmitted, required TextEditingController controller});

  @override
  _CodeInputState createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  void _handleTextChange(String text, int index) {
    if (text.length == 1 && index < 5) {
      _focusNodes[index].unfocus();
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }

    if (index == 5) {
      _focusNodes[index].unfocus();
      widget.onSubmitted(
        _controllers.map((controller) => controller.text).join(),
      );
    }
  }

  void _clearFields() {
    _controllers.forEach((controller) => controller.clear());
    FocusScope.of(context).requestFocus(_focusNodes[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            6,
            (index) => SizedBox(
              width: 40,
              child: TextField(
                focusNode: _focusNodes[index],
                controller: _controllers[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (text) => _handleTextChange(text, index),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xff79747E)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Color(0xffFFFFFF),
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: _clearFields,
          child: Text(
            'Clear',
            style: TextStyle(fontSize: 16, color: Colors.redAccent),
          ),
        ),
      ],
    );
  }
}

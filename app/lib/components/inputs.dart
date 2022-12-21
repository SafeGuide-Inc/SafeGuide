import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final String label;
  final String errorMessage;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool isPassword;

  const CodeInput(
      {super.key,
      this.label = 'Something',
      this.errorMessage = '',
      this.keyboardType = TextInputType.text,
      this.controller,
      this.isPassword = false});

  @override
  State<CodeInput> createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleNumberInput(),
            SingleNumberInput(),
            SingleNumberInput(),
            SingleNumberInput(),
            SingleNumberInput(),
            SingleNumberInput(),
          ],
        ),
        widget.errorMessage.isNotEmpty
            ? Text(widget.errorMessage,
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.red))
            : Container(),
        const SizedBox(height: 20),
        InkWell(
          onTap: () => {print('object')},
          child: Container(
            alignment: Alignment.center,
            child: Text('Clear',
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff79747E))),
          ),
        )
      ]),
    );
  }
}

class SingleNumberInput extends StatefulWidget {
  const SingleNumberInput({super.key, this.controller});
  final TextEditingController? controller;

  @override
  State<SingleNumberInput> createState() => _SingleNumberInputState();
}

class _SingleNumberInputState extends State<SingleNumberInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40,
        height: 70,
        margin: const EdgeInsets.only(top: 8, bottom: 4),
        child: TextField(
            controller: widget.controller,
            keyboardType: TextInputType.emailAddress,
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xff79747E))),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: const Color(0xffFFFFFF))));
  }
}

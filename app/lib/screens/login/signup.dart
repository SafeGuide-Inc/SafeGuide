import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../components/buttons.dart';
import '../../components/inputs.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String userId = '';
  String email = '';

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      setState(() {
        userId = arguments['userId'] as String;
        email = arguments['email'] as String;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: SafeArea(
            child: ResponsiveGridRow(children: [
          ResponsiveGridCol(
            xs: 12,
            sm: 12,
            md: 6,
            child: LimitedBox(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                child: SignUpContainer(userId: userId, email: email)),
          ),
          ResponsiveGridCol(
              xs: 0,
              sm: 0,
              md: 6,
              child: Visibility(
                visible: MediaQuery.of(context).size.width > 600,
                child: LimitedBox(
                    maxHeight: double.infinity,
                    maxWidth: double.infinity,
                    child: Container(
                      margin: EdgeInsets.only(top: 15.h),
                      child: Center(
                        child: Lottie.network(
                            'https://assets5.lottiefiles.com/private_files/lf30_p5tali1o.json'),
                      ),
                    )),
              ))
        ])));
  }
}

class SignUpContainer extends StatefulWidget {
  final String userId;
  final String email;

  const SignUpContainer({
    Key? key,
    required this.userId,
    required this.email,
  }) : super(key: key);

  @override
  State<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88.h,
      margin: EdgeInsets.only(left: 7.w, right: 7.w, top: 1.h),
      child: Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text('Complete Activation',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.raleway(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xffFF5757)))),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
              child: Text(
                  'Some text saying that you need to fill the next form to activate your account and start using Safe Guide.',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black))),
          const SizedBox(
            height: 20,
          ),
          Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text('Email',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xff79747E)))),
          const SizedBox(
            height: 2,
          ),
          Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text(widget.email,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black))),
          const SizedBox(
            height: 13,
          ),
          Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text('University',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xff79747E)))),
          const SizedBox(
            height: 2,
          ),
          Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text('University of Oregon',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black))),
          const TextInput(label: 'Name'),
          const TextInput(label: 'Last name'),
          const TextInput(label: 'Phone number'),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: SwitchListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'I accept the user terms and data collection.',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
                value: false,
                activeColor: Colors.redAccent,
                inactiveTrackColor: Colors.grey,
                onChanged: (bool value) {}),
          ),
          Button(
              isLoading: false,
              title: 'Submit',
              onPressed: () => Navigator.pop(context))
        ],
      ),
    );
  }
}

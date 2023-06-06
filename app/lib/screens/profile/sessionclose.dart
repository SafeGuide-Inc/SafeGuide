import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safeguide/api/supabase.dart';
import 'package:safeguide/screens/login/home.dart';
import 'package:sizer/sizer.dart';

class SessionClose extends StatefulWidget {
  const SessionClose({Key? key}) : super(key: key);

  @override
  State<SessionClose> createState() => _SessionCloseState();
}

class _SessionCloseState extends State<SessionClose> {
  void closeSession() async {
    await supabase.auth.signOut();
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) =>
                const LoginHome()), // Replace this with your actual login home screen widget.
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    closeSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: Colors.redAccent,
              ),
              Container(
                margin: EdgeInsets.only(top: 5.h),
                child: Text('See you soon!',
                    style: GoogleFonts.roboto(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade800)),
              )
            ],
          ),
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:lottie/lottie.dart';
import 'package:safeguide/api/supabase.dart';
import 'package:safeguide/const/utils.dart';
import 'package:sizer/sizer.dart';

import '../../components/buttons.dart';
import '../../components/inputs.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: SingleChildScrollView(
            child: SafeArea(
                child: ResponsiveGridRow(children: [
          ResponsiveGridCol(
            xs: 12,
            sm: 12,
            md: 6,
            child: const LimitedBox(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                child: LoginContainer()),
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
        ]))));
  }
}

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88.h,
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/images/logo.png',
              width: 60.w,
              alignment: Alignment.topCenter,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
              child: Text('It’s time for a modern solution to student safety.',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black))),
          SizedBox(
            height: 7.h,
          ),
          TextInput(label: 'Email', controller: _emailController),
          const SizedBox(
            height: 10,
          ),
          Button(
              isLoading: false,
              title: 'Login',
              onPressed: (() => {
                    HapticFeedback.lightImpact(),
                    authUser(
                        convertToGmailEmail(_emailController.text), context)
                  })),
          const Spacer(),
          Text('Don’t you have an account?',
              textAlign: TextAlign.left,
              style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffA6A6A6))),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.pushNamed(context, '/activation');
            },
            child: SizedBox(
                child: Text('Activate account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xffFF5757)))),
          ),
          const Spacer(),
          Text('Made with ❤️ by SafeGuide Inc.',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xff9AA7B2))),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}

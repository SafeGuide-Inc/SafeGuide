import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../components/buttons.dart';
import '../../components/inputs.dart';

class Activation extends StatefulWidget {
  const Activation({super.key});

  @override
  State<Activation> createState() => _ActivationState();
}

class _ActivationState extends State<Activation> {
  var initialPage = 1;

  renderer(page) {
    switch (page) {
      case 0:
        return ActivationContainer();
      case 1:
        return ValidateIdentity();
      case 2:
        return DeniedContainer();
      default:
        return ActivationContainer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Container(
                margin: EdgeInsets.only(left: 6.w),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.black, size: 20),
                      SizedBox(width: 1.w),
                      Text('Back',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ))),
        backgroundColor: const Color(0xffF5F5F5),
        body: ResponsiveGridRow(children: [
          ResponsiveGridCol(
            xs: 12,
            sm: 12,
            md: 6,
            child: LimitedBox(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                child: renderer(2)),
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
        ]));
  }
}

class ActivationContainer extends StatefulWidget {
  const ActivationContainer({super.key});

  @override
  State<ActivationContainer> createState() => _ActivationContainerState();
}

class _ActivationContainerState extends State<ActivationContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text('Activate user',
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
                  'Some text saying that you need to put your university email and the system is going to validate it.',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black))),
          SizedBox(
            height: 7.h,
          ),
          const TextInput(label: 'Email'),
          const SizedBox(
            height: 10,
          ),
          Button(isLoading: false, title: 'Continue', onPressed: () => {}),
        ],
      ),
    );
  }
}

class DeniedContainer extends StatefulWidget {
  const DeniedContainer({super.key});

  @override
  State<DeniedContainer> createState() => _DeniedContainerState();
}

class _DeniedContainerState extends State<DeniedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text('This university is not registered',
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
                  'Some text saying that your university is not registered or validate that the domain is correct.',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black))),
          SizedBox(
            height: 25.h,
          ),
          Button(
              isLoading: false,
              title: 'Back',
              onPressed: () => Navigator.pop(context)),
          const SizedBox(height: 45),
          Text('Problems validating your email?',
              textAlign: TextAlign.left,
              style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffA6A6A6))),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/activation');
            },
            child: SizedBox(
                child: Text('Get help',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xffFF5757)))),
          )
        ],
      ),
    );
  }
}

class ValidateIdentity extends StatefulWidget {
  const ValidateIdentity({super.key});

  @override
  State<ValidateIdentity> createState() => _ValidateIdentityState();
}

class _ValidateIdentityState extends State<ValidateIdentity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text('Validate Identity',
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
                  'Some text saying that you must check your email and put the received verification code.',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black))),
          SizedBox(
            height: 7.h,
          ),
          const CodeInput(label: 'Verification code:'),
          const SizedBox(
            height: 30,
          ),
          Button(
              isLoading: false,
              title: 'Verify',
              onPressed: () => Navigator.pushNamed(context, '/signup')),
          const SizedBox(height: 70),
          Text('Not receiving the code?',
              textAlign: TextAlign.left,
              style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffA6A6A6))),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/activation');
            },
            child: SizedBox(
                child: Text('Get help',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xffFF5757)))),
          )
        ],
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:lottie/lottie.dart';
import 'package:safeguide/api/supabase.dart';
import 'package:safeguide/const/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/buttons.dart';
import '../../components/inputs.dart';

final storage = FlutterSecureStorage();

class Activation extends StatefulWidget {
  const Activation({Key? key}) : super(key: key);

  @override
  State<Activation> createState() => _ActivationState();
}

class _ActivationState extends State<Activation> {
  int _step = 0;
  String _email = '';

  void changeStep(int newStep, [String? email]) {
    setState(() {
      _step = newStep;
      if (email != null) _email = email;
    });
  }

  Widget renderer(int page) {
    switch (page) {
      case 0:
        return ActivationContainer(stepFunction: changeStep);
      case 1:
        return ValidateIdentity(email: _email, stepFunction: changeStep);
      case 2:
        return DeniedContainer(stepFunction: changeStep);
      default:
        return ActivationContainer(stepFunction: changeStep);
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
                  onTap: () =>
                      {HapticFeedback.lightImpact(), Navigator.pop(context)},
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.black, size: 20),
                      SizedBox(width: 1.w),
                      Text('',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ))),
        backgroundColor: const Color(0xffF5F5F5),
        body: SingleChildScrollView(
            child: ResponsiveGridRow(children: [
          ResponsiveGridCol(
            xs: 12,
            sm: 12,
            md: 6,
            child: LimitedBox(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                child: renderer(_step)),
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

class ActivationContainer extends StatefulWidget {
  ActivationContainer({Key? key, required this.stepFunction}) : super(key: key);

  final Function stepFunction;

  @override
  State<ActivationContainer> createState() => _ActivationContainerState();
}

class _ActivationContainerState extends State<ActivationContainer> {
  TextEditingController _emailController = TextEditingController();
  String _email = '';

  void createUser(String email) async {
    //await supabase.auth.signOut(); //For test only
    _email = email;
    await supabase.auth
        .signInWithOtp(email: email)
        .then((value) => {widget.stepFunction(1, _email)});
  }

  validateEmail() {
    if (_emailController.text.contains('.edu')) {
      createUser(convertToGmailEmail(_emailController.text));
    } else {
      widget.stepFunction(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
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
                  'Please enter your university email address to sign up for SafeGuide',
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
              title: 'Continue',
              onPressed: () => {HapticFeedback.lightImpact(), validateEmail()}),
        ],
      ),
    );
  }
}

class DeniedContainer extends StatefulWidget {
  DeniedContainer({super.key, this.stepFunction});

  var stepFunction;

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
            height: 2.h,
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
                  'Please verify that your domain is entered correctly. If the problem persists, your university may not offer SafeGuide at this time.',
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
              onPressed: () =>
                  {HapticFeedback.lightImpact(), Navigator.pop(context)}),
          const SizedBox(height: 45),
          Text('Problems validating your email?',
              textAlign: TextAlign.left,
              style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffA6A6A6))),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'help@safeguideinc.com',
              );

              if (await canLaunchUrl(emailLaunchUri)) {
                await launchUrl(emailLaunchUri);
              } else {
                throw 'Could not launch $emailLaunchUri';
              }
              ;
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
  ValidateIdentity({Key? key, required this.stepFunction, required this.email})
      : super(key: key);

  final Function stepFunction;
  final String email;

  @override
  State<ValidateIdentity> createState() => _ValidateIdentityState();
}

class _ValidateIdentityState extends State<ValidateIdentity> {
  TextEditingController _codeController = TextEditingController();
  String _code = '';

  Future<void> storeUserId(String userId) async {
    await storage.write(key: 'userId', value: userId);
  }

  Future<void> validateAccess(String email, String token) async {
    print(email + ' ' + token);
    final response = await supabase.auth
        .verifyOTP(email: email, token: token, type: OtpType.magiclink);

    print(response);
    print(response.user?.id);
    print(response.user?.email);

    final user = response.user;

    if (user != null) {
      String userId = user.id;
      print('User ID: ' + userId);
      await storeUserId(userId);
      Navigator.pushNamed(context, '/signup',
          arguments: {'userId': userId, 'email': email});
    } else {
      print('Error validating user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
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
                  'Please enter the code received in your email to continue.',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black))),
          SizedBox(
            height: 7.h,
          ),
          CodeInput(
            controller: _codeController,
            onSubmitted: (code) {
              setState(() {
                _code = code;
              });
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Button(
              isLoading: false,
              title: 'Verify',
              onPressed: () async {
                if (_code.length == 6) {
                  await validateAccess(widget.email, _code);
                }
              }),
          const SizedBox(height: 70),
          Text('Not receiving the code?',
              textAlign: TextAlign.left,
              style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffA6A6A6))),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'help@safeguideinc.com',
              );

              if (await canLaunchUrl(emailLaunchUri)) {
                await launchUrl(emailLaunchUri);
              } else {
                throw 'Could not launch $emailLaunchUri';
              }
              ;
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

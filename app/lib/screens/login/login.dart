import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:lottie/lottie.dart';
import 'package:safeguide/api/supabase.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/buttons.dart';
import '../../components/inputs.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      setState(() {
        email = arguments['email'] as String;
      });
    });
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
                      {Navigator.pop(context), HapticFeedback.lightImpact()},
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
        body: ResponsiveGridRow(children: [
          ResponsiveGridCol(
            xs: 12,
            sm: 12,
            md: 6,
            child: LimitedBox(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                child: LoginContainer(email: email)),
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

class LoginContainer extends StatefulWidget {
  const LoginContainer({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  TextEditingController _codeController = TextEditingController();
  var _code = '';
  bool _isLoading = false;

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
              child: Text('Login',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.raleway(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xffFF5757)))),
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
              child: Text(
                  'Please check your email for the verification code.',
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
              isLoading: _isLoading,
              title: 'Continue',
              onPressed: () => {
                    if (_code.length == 6) print(_code),
                    {
                      setState(() {
                        _isLoading = true;
                      }),
                      HapticFeedback.lightImpact(),
                      validateAccess(widget.email, _code, context)
                    }
                  }),
          const SizedBox(height: 70),
          Text('Problems login in your account?',
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
              };
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
            onTap: () async {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'help@safeguideinc.com',
              );

              if (await canLaunchUrl(emailLaunchUri)) {
                await launchUrl(emailLaunchUri);
              } else {
                throw 'Could not launch $emailLaunchUri';
              };
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

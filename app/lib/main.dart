import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:safeguide/screens/home/home.dart';

import 'package:safeguide/screens/login/home.dart';
import 'package:safeguide/screens/login/login.dart';
import 'package:safeguide/screens/login/activate.dart';
import 'package:safeguide/screens/login/signup.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(Sizer(builder: (context, orientation, deviceType) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ))),
      initialRoute: '/',
      routes: {
        '/': (context) => const Main(),
        '/loginHome': (context) => const LoginHome(),
        '/login': (context) => const Login(),
        '/activation': (context) => const Activation(),
        '/signup': (context) => const SignUp(),
        '/home': (context) => const Home()
      },
    );
  }));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamed(context, '/loginHome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
          backgroundColor: Color(0xff1c1e21),
          body: Center(
            child: CircularProgressIndicator(),
          )),
    );
  }
}

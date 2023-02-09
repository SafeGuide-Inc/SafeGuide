import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:safeguide/components/navbar.dart';
import 'package:safeguide/screens/home/feed.dart';
import 'package:safeguide/screens/home/mapview.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/buttons.dart';
import '../../components/cardSlider.dart';
import '../../components/inputs.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const MainView();
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  int _currentIndex = 0;
  final List<Widget> _pages = [MapView(), FeedView()];

  void changeView(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: CustomBottomNavBar(
            viewChangeFunction: changeView, index: _currentIndex),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white.withOpacity(0.75),
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: SizedBox(
              height: 5.h,
              child: Image.asset("assets/images/logo.png"),
            )),
        body: _pages[_currentIndex]);
  }
}

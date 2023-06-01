import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../components/buttons.dart';
import 'package:safeguide/components/inputs.dart' as SafeGuideInputs;

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  String userId = '';
  String email = 'moydanh@uoregon.edu';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.black, size: 35),
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Edit account',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
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
                child: UserAccountContainer(userId: userId, email: email)),
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

class UserAccountContainer extends StatefulWidget {
  final String userId;
  final String email;

  const UserAccountContainer({
    Key? key,
    required this.userId,
    required this.email,
  }) : super(key: key);

  @override
  State<UserAccountContainer> createState() => _UserAccountContainerState();
}

class _UserAccountContainerState extends State<UserAccountContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 7.w, right: 7.w, top: 1.h),
      child: Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            height: 1.h,
          ),
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
          const SafeGuideInputs.TextInput(label: 'Name'),
          const SafeGuideInputs.TextInput(label: 'Last name'),
          const SafeGuideInputs.TextInput(label: 'Phone number'),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            child: Button(
                isLoading: false,
                title: 'Update Info',
                onPressed: () => Navigator.pop(context)),
          )
        ],
      ),
    );
  }
}

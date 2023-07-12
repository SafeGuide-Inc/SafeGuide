import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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
        body: SingleChildScrollView(
            child: UserAccountContainer(userId: userId, email: email)));
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
  TextEditingController nameController = TextEditingController(text: "Moises");
  TextEditingController lastNameController =
      TextEditingController(text: "Daniel");
  TextEditingController phoneNumberController =
      TextEditingController(text: "7757717060");

  void _showDeleteConfirmationDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/closeSession');
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

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
          SafeGuideInputs.TextInput(label: 'Name', controller: nameController),
          SafeGuideInputs.TextInput(
              label: 'Last name', controller: lastNameController),
          SafeGuideInputs.TextInput(
              label: 'Phone number', controller: phoneNumberController),
          const SizedBox(
            height: 10,
          ),
          Button(
              isLoading: false,
              title: 'Update Info',
              onPressed: () => Navigator.pop(context)),
          const SizedBox(
            height: 65,
          ),
          GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                _showDeleteConfirmationDialog(context);
              },
              child: Text('Delete Account',
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.w900)))
        ],
      ),
    );
  }
}

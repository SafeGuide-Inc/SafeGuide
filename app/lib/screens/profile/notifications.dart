import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class UserNotifications extends StatefulWidget {
  @override
  _UserNotificationsState createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  List<Map<String, dynamic>> notificationSettings = [
    {
      'id': "332123",
      'name': 'Around you',
      'description':
          'Receive alert of incidents close to your current location',
      'active': true
    },
    {
      'id': "645345",
      'name': 'Around the campus',
      'description':
          'Receive alerts of incidents close to your campus location',
      'active': false
    },
    {
      'id': "87568",
      'name': 'Inside the campus',
      'description': 'Receive alert of incidents inside your campus',
      'active': false
    }
  ];

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
          'Notifications',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
            child: Container(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: notificationSettings.length,
            itemBuilder: (context, index) {
              return SwitchListTile(
                activeColor: Colors.redAccent,
                title: Text(notificationSettings[index]['name'],
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    )),
                subtitle: Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(notificationSettings[index]['description'],
                      style: GoogleFonts.poppins()),
                ),
                value: notificationSettings[index]['active'] ??
                    false, // Handle potential null value
                onChanged: (bool value) {
                  HapticFeedback.mediumImpact();
                  setState(() {
                    notificationSettings[index]['active'] = value;
                  });
                  print(notificationSettings);
                },
              );
            },
          ),
        ))
      ]),
    );
  }
}

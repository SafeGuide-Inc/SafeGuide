import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationItem {
  final String incident;
  final String time;
  final String zone;

  NotificationItem(
      {required this.incident, required this.time, required this.zone});
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> _notifications = [
    NotificationItem(incident: 'Thieft', time: '8:00 AM', zone: 'Eugene'),
    NotificationItem(
        incident: 'Drugs Selling', time: '9:30 AM', zone: 'Eugene'),
    NotificationItem(incident: 'Accident', time: '10:45 AM', zone: 'Eugene'),
  ];

  void _clearAll() {
    setState(() {
      _notifications.clear();
    });
  }

  void _deleteNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final item = _notifications[index];
          return Dismissible(
            key: Key(item.incident),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              _deleteNotification(index);
            },
            background: Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Icon(Icons.delete, color: Colors.white),
                ],
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(item.incident),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.zone),
                          Text(item.time, style: TextStyle(color: Colors.grey))
                        ],
                      ),
                    ],
                  ),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        Icon(Icons.notification_important, color: Colors.white),
                  ),
                  onTap: () {
                    HapticFeedback.lightImpact();
                  },
                ),
                Divider(height: 0),
              ],
            ),
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              _clearAll();
            },
            child: Container(
              margin: EdgeInsets.only(right: 20, top: 20),
              child: Text(
                'Clear All',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safeguide/const/types.dart';
import 'package:sizer/sizer.dart';

class FeedCard extends StatelessWidget {
  final String title;
  final String username;
  final String text;
  final String date;
  final String imageUrl;
  final IconData icon;

  FeedCard({
    this.title = 'Something',
    this.username = 'Someone',
    this.text = 'Some text',
    this.date = 'Some date',
    this.imageUrl = 'https://picsum.photos/250?image=9',
    this.icon = Icons.person,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(icon),
            title: Text(title),
            subtitle: Text(username),
          ),
          Text(text),
          Image.network(imageUrl),
          Text(date),
        ],
      ),
    );
  }
}

class IncidentDetails extends StatelessWidget {
  final Incident incident;
  final VoidCallback onBack;

  const IncidentDetails({
    Key? key,
    required this.incident,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
              width: 83.w,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      incident.icon,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Container(
                    width: 45.w,
                    child: Text(
                      incident.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: IconButton(
                      padding: const EdgeInsets.only(bottom: 10, left: 25),
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        onBack();
                      },
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 10),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Text(incident.description)),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class Incident {
  final String name;
  final IconData icon;
  final String id;
  final String description;

  Incident(this.name, this.icon, this.id, this.description);
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
    return Column(children: [
      Container(height: 15.h, color: Colors.transparent),
      Container(
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
                    Text(
                      incident.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(bottom: 10, left: 25),
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        onBack();
                      },
                    ),
                  ],
                )),
            const SizedBox(height: 10),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id tellus sapien. Sed vulputate ipsum in enim maximus sodales. Sed vel malesuada dolor.',
                )),
            const SizedBox(height: 25),
          ],
        ),
      )
    ]);
  }
}

import 'package:flutter/material.dart';

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

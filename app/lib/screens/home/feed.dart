import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safeguide/components/cards.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  final List<Map<String, dynamic>> feedData = [
    {
      'title': 'First Post',
      'username': 'John Doe',
      'text': 'This is the first post.',
      'date': 'Jan 1, 2021',
      'imageUrl': 'https://via.placeholder.com/150',
      'icon': Icons.person
    },
    {
      'title': 'Second Post',
      'username': 'Jane Smith',
      'text': 'This is the second post.',
      'date': 'Jan 2, 2021',
      'imageUrl': 'https://via.placeholder.com/150',
      'icon': Icons.person,
    },
    {
      'title': 'Second Post',
      'username': 'Jane Smith',
      'text': 'This is the second post.',
      'date': 'Jan 2, 2021',
      'imageUrl': 'https://via.placeholder.com/150',
      'icon': Icons.person,
    },
    {
      'title': 'Second Post',
      'username': 'Jane Smith',
      'text': 'This is the second post.',
      'date': 'Jan 2, 2021',
      'imageUrl': 'https://via.placeholder.com/150',
      'icon': Icons.person,
    },
    // Add more feed data here as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: feedData.length,
      itemBuilder: (context, index) {
        return FeedCard(
          title: feedData[index]['title'],
          username: feedData[index]['username'],
          text: feedData[index]['text'],
          date: feedData[index]['date'],
          imageUrl: feedData[index]['imageUrl'],
          icon: feedData[index]['icon'],
        );
      },
    );
  }
}

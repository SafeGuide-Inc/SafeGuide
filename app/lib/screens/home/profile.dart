import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileOptions extends StatelessWidget {
  final List<Map<String, String>> _options = [
    {
      'name': 'Account',
      'routeName': '/userAccount',
    },
    {
      'name': 'Notifications',
      'routeName': '/notifications',
    },
    {
      'name': 'Help',
      'routeName': '/help',
    },
    {
      'name': 'Close session',
      'routeName': '/closeSession',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_options[index]['name']!),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            HapticFeedback.mediumImpact();
            Navigator.pushNamed(context, _options[index]['routeName']!);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: _options.length,
    );
  }
}

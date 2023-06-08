import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

convertToLocalTime(String utcTime) {
  DateTime dateTime = DateTime.parse(utcTime).toLocal();
  String formattedTime = DateFormat("yyyy-MM-dd HH:mm").format(dateTime);
  return formattedTime;
}

IconData getIconForIncident(String incidentName) {
  Map<String, IconData> incidentIconMap = {
    'Car Theft': Icons.directions_car,
    'Home Break-in': Icons.home,
    'Pickpocket': Icons.account_circle,
  };

  IconData? icon = incidentIconMap[incidentName];
  return icon ?? Icons.error_outline;
}

IconData getIconForCategory(String incidentName) {
  Map<String, IconData> incidentIconMap = {
    'Car Theft': Icons.directions_car,
    'Home Break-in': Icons.home,
    'Pickpocket': Icons.account_circle,
  };

  IconData? icon = incidentIconMap[incidentName];
  return icon ?? Icons.error_outline;
}

String spaceByUpper(String input) {
  String result = '';
  for (int i = 0; i < input.length; i++) {
    if (i > 0 && input[i].toUpperCase() == input[i]) {
      result += ' ';
    }
    result += input[i];
  }
  return result;
}

String convertToGmailEmail(String email) {
  final parts = email.split('@');
  if (parts.length == 2) {
    final username = parts[0];
    final domain = parts[1];

    if (domain == 'uoregon.edu') {
      return '$username@gmail.com';
    }
  }

  return email;
}

String removeSpecialCharacters(String input) {
  RegExp specialCharRegex = RegExp(r'[^\w\s]');
  String result = input.replaceAll(specialCharRegex, '');
  return result;
}

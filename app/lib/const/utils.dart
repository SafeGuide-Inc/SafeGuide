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

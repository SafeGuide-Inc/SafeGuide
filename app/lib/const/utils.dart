import 'package:flutter/material.dart';

IconData getIconForIncident(String incidentName) {
  Map<String, IconData> incidentIconMap = {
    'Car Theft': Icons.directions_car,
    'Home Break-in': Icons.home,
    'Pickpocket': Icons.account_circle,
  };

  IconData? icon = incidentIconMap[incidentName];
  return icon ?? Icons.error_outline;
}

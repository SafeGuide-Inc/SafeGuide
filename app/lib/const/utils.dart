import 'package:flutter/material.dart';

IconData getIconForIncident(String incidentName) {
  // Define the dictionary for mapping incident names to icons
  Map<String, IconData> incidentIconMap = {
    'Car Theft': Icons.directions_car,
    'Home Break-in': Icons.home,
    'Pickpocket': Icons.account_circle,
    // Add additional incidents and their corresponding icons here
  };

  // Try to get the icon for the given incident name
  IconData? icon = incidentIconMap[incidentName];

  // If an icon was found, return it. Otherwise, return a default icon
  return icon ?? Icons.error_outline;
}

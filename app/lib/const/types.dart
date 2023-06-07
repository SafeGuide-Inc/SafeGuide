import 'package:flutter/material.dart';

class Incident {
  final String name;
  final IconData icon;
  final String id;
  final String description;
  final String category;

  Incident(this.name, this.icon, this.id, this.description, this.category);
}

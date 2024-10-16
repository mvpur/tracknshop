import 'package:flutter/material.dart';

class Catalogue {
  final String id;
  final Icon icon;
  final String name;
  final DateTime date;

  Catalogue(
      {required this.id,
      required this.icon,
      required this.name,
      required this.date});
}

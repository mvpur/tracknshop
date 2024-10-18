import 'package:cloud_firestore/cloud_firestore.dart';
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

  Map<String, dynamic> toFirestore(){
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'date': date
    };
  }
  static Catalogue fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options, ){
      final data = snapshot.data();

      return Catalogue(id: data?['id'], 
      name: data?['name'],
      icon: data?['icon'], 
      date: data?['date']);
  }
}

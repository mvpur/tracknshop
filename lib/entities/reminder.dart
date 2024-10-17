import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  final String id;
  final String title;
  final String description;
  final DateTime dateTimeToRemind;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTimeToRemind
  });
  Map<String, dynamic> toFirestore(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTimeToRemind': dateTimeToRemind
    };
  }
  static Reminder fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options, ){

  }
}
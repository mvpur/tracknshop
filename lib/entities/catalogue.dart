import 'package:cloud_firestore/cloud_firestore.dart';

class Catalogue {
  final String id;
  String icon;
  final String name;
  final DateTime date;

  Catalogue(
      {required this.id,
      required this.icon,
      required this.name,
      required this.date});

  factory Catalogue.fromMap(Map<String, dynamic> data) {
    return Catalogue(
      id: data['id'] ?? '',
      icon: data['icon'] ?? '',
      name: data['name'] ?? 'Sin Nombre',
      date: (data['date'] != null && data['date'] is Timestamp)
          ? (data['date'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'icon': icon,
      'name': name,
      'date': Timestamp.fromDate(date),
    };
  }

  static Catalogue fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = {...doc.data()!, "id": doc.id};
    return Catalogue.fromMap(data);
  }

  Map<String, dynamic> toFirestoreWithOptions(
    SetOptions? options,
  ) {
    return toFirestore();
  }
}

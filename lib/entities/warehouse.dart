import 'package:cloud_firestore/cloud_firestore.dart';

class Warehouse {
  String id;
  String icon;
  String name;
  DateTime date;

  Warehouse({
    required this.id,
    required this.icon,
    required this.name,
    required this.date,
  });

  factory Warehouse.fromMap(Map<String, dynamic> data) {
    return Warehouse(
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

  factory Warehouse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = {...doc.data()!, "id": doc.id};
    return Warehouse.fromMap(data);
  }

  Map<String, dynamic> toFirestoreWithOptions(
    SetOptions? options,
  ) {
    return toFirestore();
  }
}

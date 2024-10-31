import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'category.dart';

class Warehouse {
  final String id;
  final int icon;
  final String name;
  final DateTime date;

  Warehouse({
    required this.id,
    required this.icon,
    required this.name,
    required this.date,
  });

  Icon getIcon() {
    return Icon(IconData(icon, fontFamily: 'MaterialIcons'));
  }

  factory Warehouse.fromMap(Map<String, dynamic> data) {
    return Warehouse(
      id: data['id'] ?? '',
      icon: data['icon'] ?? 0,
      name: data['name'] ?? 'Sin Nombre',
      date: (data['date'] != null && data['date'] is Timestamp)
          ? (data['date'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
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

  Future<List<Category>> loadCategories() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final categoriesSnapshot = await firestore
        .collection('category')
        .where('warehouse_id', isEqualTo: id)
        .get();

    return categoriesSnapshot.docs.map((doc) {
      return Category.fromFirestore(doc, null);
    }).toList();
  }
}

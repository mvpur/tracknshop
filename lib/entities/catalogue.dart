import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'category.dart';

class Catalogue {
  final String id;
  final int icon;
  final String name;
  final DateTime date;

  Catalogue({
    required this.id,
    required this.icon,
    required this.name,
    required this.date,
  });

  Icon getIcon() {
    return Icon(IconData(icon, fontFamily: 'MaterialIcons'));
  }

  factory Catalogue.fromMap(Map<String, dynamic> data) {
    return Catalogue(
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

  factory Catalogue.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = {...doc.data()!, "id": doc.id};
    return Catalogue.fromMap(data);
  }

  Future<List<Category>> loadCategories() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final categoriesSnapshot = await firestore
        .collection('category')
        .where('catalogue_id', isEqualTo: id)
        .get();

    return categoriesSnapshot.docs.map((doc) {
      return Category.fromFirestore(doc, null);
    }).toList();
  }

  Catalogue copyWith({
    String? name,
    int? icon,
    DateTime? date,
  }) {
    return Catalogue(
      id: id,
      icon: icon ?? this.icon,
      name: name ?? this.name,
      date: date ?? this.date,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'category.dart';

class Catalogue {
  final String id;
  int icon;
  final String name;
  final DateTime date;
  List<Category>? categories;

  Catalogue({
    required this.id,
    required this.icon,
    required this.name,
    required this.date,
    this.categories,
  });

  Icon getIcon() {
    return Icon(IconData(icon, fontFamily: 'MaterialIcons'));
  }

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

  Future<void> loadCategories() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final categoriesSnapshot = await firestore
        .collection('catalogue')
        .doc(id)
        .collection('category')
        .get();

    categories = await Future.wait(categoriesSnapshot.docs.map((doc) async {
      final category = Category.fromFirestore(
        doc,
        null,
      );
      await category.loadItems(id); // Cargar ítems de cada categoría
      return category;
    }).toList());
  }

  loadItems() {}
}

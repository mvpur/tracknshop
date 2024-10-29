import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'category.dart';

class Catalogue {
  final String id;
  String icon;
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

  // Obtener el ícono como un IconData
  IconData getIconData() {
    return IconData(icon.codeUnitAt(0), fontFamily: 'MaterialIcons');
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

  // Factory para crear Catalogue desde un DocumentSnapshot de Firestore
  factory Catalogue.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = {...doc.data()!, "id": doc.id};
    return Catalogue.fromMap(data);
  }

  // Método para cargar las categorías como subcolección desde Firestore
  Future<void> loadCategories() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final categoriesSnapshot = await firestore
        .collection('catalogue')
        .doc(id)
        .collection('category')
        .get();

    // Mapear documentos a objetos Category
    categories = categoriesSnapshot.docs.map((doc) {
      return Category.fromFirestore(
          doc.data() as DocumentSnapshot<Map<String, dynamic>>,
          doc.id as SnapshotOptions?);
    }).toList();
  }
}

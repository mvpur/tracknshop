import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:track_shop_app/entities/item.dart';

class Warehouse {
  final String id;
  final int icon;
  final String name;
  final DateTime date;
  List<Item>? items; // Lista de Items en el Warehouse

  Warehouse({
    required this.id,
    required this.icon,
    required this.name,
    required this.date,
    this.items,
  });

  Icon getIcon() {
    return Icon(IconData(icon, fontFamily: 'MaterialIcons'));
  }

  factory Warehouse.fromMap(Map<String, dynamic> data) {
    return Warehouse(
      id: data['id'] ?? '',
      icon: data['icon'] ?? Icons.cloud.codePoint,
      name: data['name'] ?? 'Sin Nombre',
      date: (data['date'] != null && data['date'] is Timestamp)
          ? (data['date'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  // Convertir un documento Firestore a un objeto Warehouse
  factory Warehouse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = {...doc.data()!, "id": doc.id};
    return Warehouse.fromMap(data);
  }

  // Convertir un objeto Warehouse a un mapa para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'icon': icon,
      'name': name,
      'date': Timestamp.fromDate(date),
    };
  }

  // Método para cargar los Items desde Firestore y llenar la lista de items
  // Método para cargar los Items desde Firestore y llenar la lista de items
  Future<void> loadItems() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final itemsSnapshot = await firestore
          .collection('warehouse')
          .doc(id)
          .collection('item')
          .get();

      items = itemsSnapshot.docs.map((doc) {
        return Item.fromFirestore(
          doc,
          null, // Aquí no necesitas SnapshotOptions
        );
      }).toList();
    } catch (e) {
      print('Error loading items: $e'); // Imprime el error en consola
    }
  }
}

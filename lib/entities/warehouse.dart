import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:track_shop_app/entities/item.dart';

class Warehouse {
  final String id;
  final int icon;
  final String name;
  final DateTime date;
  List<Item>? items;

  Warehouse({
    required this.id,
    required this.icon,
    required this.name,
    required this.date,
    this.items,
  });

  Icon getIcon() {
    Icons.list_rounded;
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

  factory Warehouse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = {...doc.data()!, "id": doc.id};
    return Warehouse.fromMap(data);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'icon': icon,
      'name': name,
      'date': Timestamp.fromDate(date),
    };
  }

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
          null,
        );
      }).toList();
    } catch (e) {
      print('Error loading items: $e');
    }
  }
}

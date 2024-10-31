import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String id;
  final String name;
  final bool isCompleted;
  final String categoryId;
  final String catalogueId;
  final String warehouseId;

  Item({
    required this.id,
    required this.name,
    this.isCompleted = false,
    required this.categoryId,
    required this.catalogueId,
    required this.warehouseId,
  });

  factory Item.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = {...doc.data()!, "id": doc.id};
    return Item.fromMap(data);
  }

  factory Item.fromMap(Map<String, dynamic> data) {
    return Item(
      id: data['id'] ?? '',
      name: data['name'] ?? 'Sin Nombre',
      categoryId: data['category_id'] ?? 'No category',
      catalogueId: data['catalogue_id'] ?? 'Sin catalogue',
      warehouseId: data['warehouse_id'] ?? 'No warehouse',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'isCompleted': isCompleted,
      'category_id': categoryId,
      'catalogue_id': catalogueId,
      'warehouse_id': warehouseId,
    };
  }
}

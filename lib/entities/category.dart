import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_shop_app/entities/item.dart';

class Category {
  final String id;
  final String name;
  final String catalogueId;
  final String warehouseId;

  Category({
    required this.id,
    required this.name,
    required this.catalogueId,
    required this.warehouseId,
  });

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
      id: data['id'] ?? '',
      name: data['name'] ?? 'Sin Nombre',
      catalogueId: data['catalogue_id'] ?? 'No catalogue',
      warehouseId: data['warehouse_id'] ?? 'No warehouse',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'catalogue_id': catalogueId,
      'warehouse_id': warehouseId,
    };
  }

  factory Category.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = {...doc.data()!, "id": doc.id};
    return Category.fromMap(data);
  }

  Future<List<Item>> loadItems() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final itemsSnapshot = await firestore
        .collection('item')
        .where('category_id', isEqualTo: id)
        .get();

    return itemsSnapshot.docs.map((doc) {
      return Item.fromFirestore(
          doc as DocumentSnapshot<Map<String, dynamic>>, null);
    }).toList();
  }
}

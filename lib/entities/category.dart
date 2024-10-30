import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_shop_app/entities/item.dart';

class Category {
  final String id;
  final String name;
  List<Item>? items;

  Category({
    required this.id,
    required this.name,
    this.items,
  });

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
      id: data['id'] ?? '',
      name: data['name'] ?? 'Sin Nombre',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
    };
  }

  factory Category.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = {...doc.data()!, "id": doc.id};
    return Category.fromMap(data);
  }

  Future<void> loadItems(String catalogueId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final itemsSnapshot = await firestore
        .collection('catalogue')
        .doc(catalogueId)
        .collection('category')
        .doc(id)
        .collection('item')
        .get();

    items = itemsSnapshot.docs.map((doc) {
      return Item.fromFirestore(
          doc as DocumentSnapshot<Map<String, dynamic>>, null);
    }).toList();
  }

  void loadCategoriesAndItems(String catalogueId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final categoriesSnapshot = await firestore
        .collection('catalogue')
        .doc(catalogueId)
        .collection('category')
        .get();

    final categories = categoriesSnapshot.docs.map((doc) async {
      final category = Category.fromFirestore(doc, null);
      await category.loadItems(catalogueId);
      return category;
    }).toList();

    // Puedes ahora usar 'categories' con sus ítems ya cargados
  }
}

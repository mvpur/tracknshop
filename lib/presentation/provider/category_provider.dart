import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/category.dart';
import 'package:track_shop_app/entities/item.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<Category>>(
  (ref) => CategoryNotifier(FirebaseFirestore.instance),
);

class CategoryNotifier extends StateNotifier<List<Category>> {
  final FirebaseFirestore db;

  CategoryNotifier(this.db) : super([]) {
    _listenToCategories();
  }

  void _listenToCategories() {
    db
        .collection('category')
        .orderBy('name')
        .withConverter(
          fromFirestore: Category.fromFirestore,
          toFirestore: (Category category, _) => category.toFirestore(),
        )
        .snapshots()
        .listen((snapshot) {
      state = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> addCategory(Category category) async {
    final doc = db.collection('category').doc();
    try {
      await doc.set(category.toFirestore());
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await db.collection('category').doc(id).delete();
    } catch (e) {
      print('Error deleting category: $e');
    }
  }

  Future<List<Category>> getCategoriesForCatalogue(String catalogueId) async {
    try {
      final categoriesSnapshot = await db
          .collection('category')
          .where('catalogue_id', isEqualTo: catalogueId)
          .get();

      return categoriesSnapshot.docs.map((doc) {
        return Category.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>, null);
      }).toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  Future<List<Item>> getItemsForCategory(String categoryId) async {
    try {
      final itemsSnapshot = await db
          .collection('item')
          .where('category_id', isEqualTo: categoryId)
          .get();

      return itemsSnapshot.docs.map((doc) {
        return Item.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>, null);
      }).toList();
    } catch (e) {
      print('Error fetching items: $e');
      return [];
    }
  }

  Future<List<Category>> getCategoriesForWarehouse(String warehouseId) async {
    try {
      final categoriesSnapshot = await db
          .collection('category')
          .where('warehouse_id', isEqualTo: warehouseId)
          .get();

      return categoriesSnapshot.docs.map((doc) {
        return Category.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>, null);
      }).toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  Future<List<Item>> getItemsForWarehouse(String warehouseId) async {
    try {
      final itemsSnapshot = await db
          .collection('item')
          .where('warehouse_id', isEqualTo: warehouseId)
          .get();

      return itemsSnapshot.docs.map((doc) {
        return Item.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>, null);
      }).toList();
    } catch (e) {
      print('Error fetching items: $e');
      return [];
    }
  }
}

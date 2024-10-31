import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/item.dart';

final itemProvider = StateNotifierProvider<ItemNotifier, List<Item>>(
  (ref) => ItemNotifier(FirebaseFirestore.instance),
);

class ItemNotifier extends StateNotifier<List<Item>> {
  final FirebaseFirestore db;

  ItemNotifier(this.db) : super([]) {
    _listenToItems();
  }

  void _listenToItems() {
    db.collection('item').snapshots().listen((snapshot) {
      state =
          snapshot.docs.map((doc) => Item.fromFirestore(doc, null)).toList();
    });
  }

  Future<void> addItem(Item item) async {
    final doc = db.collection('item').doc();
    try {
      await doc.set(item.toFirestore());
    } catch (e) {
      print('Error adding item: $e');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await db.collection('item').doc(id).delete();
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  Future<List<Item>> getItemsForCategory(String categoryId) async {
    try {
      final itemsSnapshot = await db
          .collection('item')
          .where('category_id', isEqualTo: categoryId)
          .get();

      return itemsSnapshot.docs.map((doc) {
        return Item.fromFirestore(doc, null);
      }).toList();
    } catch (e) {
      print('Error fetching items: $e');
      return [];
    }
  }
}

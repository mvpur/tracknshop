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
    db
        .collection('item') // Suponiendo que tienes una colección de items
        .withConverter(
          fromFirestore: Item.fromFirestore,
          toFirestore: (Item item, _) => item.toFirestore(),
        )
        .snapshots()
        .listen((snapshot) {
      state = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> addItem(Item item) async {
    final doc = db.collection('items').doc();
    try {
      await doc.set(item.toFirestore());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateItem(Item item) async {
    try {
      await db.collection('items').doc(item.id).update(item.toFirestore());
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await db.collection('items').doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
}

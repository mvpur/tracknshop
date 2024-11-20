import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/item.dart';
import 'package:track_shop_app/presentation/provider/user_provider.dart';

final itemProvider = StateNotifierProvider<ItemNotifier, List<Item>>(
  (ref) {
    final userNotifier = ref.read(userProvider.notifier);
    return ItemNotifier(userNotifier);
  },
);

class ItemNotifier extends StateNotifier<List<Item>> {
  final UserNotifier userNotifier;
  ItemNotifier(this.userNotifier) : super([]) {
    _listenToItems();
  }

  Future<void> _listenToItems() async {
    final userReference = await userNotifier.getDocumentReference();
    userReference.collection('item').snapshots().listen((snapshot) {
      state =
          snapshot.docs.map((doc) => Item.fromFirestore(doc, null)).toList();
    });
  }

  Future<void> addItem(Item item) async {
    final userReference = await userNotifier.getDocumentReference();
    final doc = userReference.collection('item').doc();
    try {
      await doc.set(item.toFirestore());
    } catch (e) {
      print('Error adding item: $e');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      final userReference = await userNotifier.getDocumentReference();
      await userReference.collection('item').doc(id).delete();
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  Future<List<Item>> getItemsForCategory(String categoryId) async {
    try {
      final userReference = await userNotifier.getDocumentReference();
      final itemsSnapshot = await userReference
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/category.dart';

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
        .orderBy('date', descending: true)
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
      print(e);
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await db.collection('category').doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
}

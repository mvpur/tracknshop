import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/category.dart';
import 'package:track_shop_app/presentation/provider/user_provider.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<Category>>(
  (ref) {
    final userNotifier = ref.read(userProvider.notifier);
    return CategoryNotifier(userNotifier);
  },
);

class CategoryNotifier extends StateNotifier<List<Category>> {
  final UserNotifier userNotifier;

  CategoryNotifier(this.userNotifier) : super([]) {
    _listenToCategories();
  }

  Future<void> _listenToCategories() async {
    final userReference = await userNotifier.getDocumentReference();
    userReference
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
    final userReference = await userNotifier.getDocumentReference();
    final doc = userReference.collection('category').doc();
    try {
      await doc.set(category.toFirestore());
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  Future<void> deleteCategory(String id) async {
    final userReference = await userNotifier.getDocumentReference();
    try {
      final itemsQuery = await userReference
          .collection('item')
          .where('category_id', isEqualTo: id)
          .get();

      for (var itemDoc in itemsQuery.docs) {
        await itemDoc.reference.delete();
      }

      await userReference.collection('category').doc(id).delete();
    } catch (e) {
      print('Error deleting category and its items: $e');
    }
  }

  void assignWarehouse({
    required String categoryId,
    required String warehouseId,
  }) async {
    try {
      final userReference = await userNotifier.getDocumentReference();
      final categoryDoc = userReference.collection('category').doc(categoryId);

      await categoryDoc.update({'warehouse_id': warehouseId});

      state = state.map((category) {
        if (category.id == categoryId) {
          return Category(
            id: category.id,
            name: category.name,
            catalogueId: category.catalogueId,
            warehouseId: warehouseId,
          );
        }
        return category;
      }).toList();
    } catch (e) {
      print('Error assigning warehouse: $e');
    }
  }

  void assignCatalogue({
    required String categoryId,
    required String catalogueId,
  }) async {
    try {
      final userReference = await userNotifier.getDocumentReference();
      final categoryDoc = userReference.collection('category').doc(categoryId);

      await categoryDoc.update({'catalogue_id': catalogueId});

      state = state.map((category) {
        if (category.id == categoryId) {
          return Category(
            id: category.id,
            name: category.name,
            warehouseId: category.warehouseId,
            catalogueId: catalogueId,
          );
        }
        return category;
      }).toList();
    } catch (e) {
      print('Error assigning catalogue: $e');
    }
  }
}

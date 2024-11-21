import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:track_shop_app/presentation/provider/user_provider.dart';

final catalogueProvider =
    StateNotifierProvider<CatalogueNotifier, List<Catalogue>>(
  (ref) {
    final userNotifier = ref.read(userProvider.notifier);
    return CatalogueNotifier(userNotifier);
  },
);

class CatalogueNotifier extends StateNotifier<List<Catalogue>> {
  final UserNotifier userNotifier;
  CatalogueNotifier(this.userNotifier) : super([]) {
    _listenToCatalogues();
  }

  Future<void> _listenToCatalogues() async {
    final userReference = await userNotifier.getDocumentReference();
    userReference
        .collection('catalogue')
        .orderBy('date', descending: true)
        .withConverter(
          fromFirestore: Catalogue.fromFirestore,
          toFirestore: (Catalogue catalogue, _) => catalogue.toFirestore(),
        )
        .snapshots()
        .listen((snapshot) async {
      final catalogues = await Future.wait(snapshot.docs.map((doc) async {
        final catalogue = doc.data();
        await catalogue.loadCategories();
        return catalogue;
      }).toList());

      state = catalogues;
    });
  }

  Future<void> addCatalogue(Catalogue catalogue) async {
    final userReference = await userNotifier.getDocumentReference();
    final doc = userReference.collection('catalogue').doc();
    try {
      await doc.set(catalogue.toFirestore());
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteCatalogue(String id) async {
    final userReference = await userNotifier.getDocumentReference();
    try {
      final categoriesQuery = await userReference
          .collection('category')
          .where('catalogue_id', isEqualTo: id)
          .get();

      for (var categoryDoc in categoriesQuery.docs) {
        final categoryData = categoryDoc.data();

        if (categoryData['catalogue_id'] == null) {
          // Eliminamos la categoría directamente desde CatalogueNotifier
          await categoryDoc.reference.delete();
        } else {
          await categoryDoc.reference
              .update({'catalogue_id': FieldValue.delete()});
        }
      }

      // Eliminar el catalogue
      await userReference.collection('catalogue').doc(id).delete();
    } catch (e) {
      print('Error deleting catalogue and its linked categories: $e');
    }
  }

  void updateCatalogueDate(String catalogueId) async {
    final userReference = await userNotifier.getDocumentReference();
    try {
      final catalogueDoc =
          userReference.collection('catalogue').doc(catalogueId);
      await catalogueDoc.update({'date': DateTime.now()});
    } catch (e) {
      print('Error updating catalogue date: $e');
    }
  }
}

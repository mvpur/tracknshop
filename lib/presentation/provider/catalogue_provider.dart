import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/catalogue.dart';

final catalogueProvider =
    StateNotifierProvider<CatalogueNotifier, List<Catalogue>>(
  (ref) => CatalogueNotifier(FirebaseFirestore.instance),
);

class CatalogueNotifier extends StateNotifier<List<Catalogue>> {
  final FirebaseFirestore db;
  CatalogueNotifier(this.db) : super([]) {
    _listenToCatalogues();
  }

  void _listenToCatalogues() {
    db
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
    final doc = db.collection('catalogue').doc();
    try {
      await doc.set(catalogue.toFirestore());
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteCatalogue(String id) async {
    try {
      await db.collection('catalogue').doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
}

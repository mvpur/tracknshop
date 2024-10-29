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
        .collection('catalogues') // Cambiado de 'catalogue' a 'catalogues'
        .orderBy('date', descending: true) // Ordenar por el campo 'date'
        .withConverter(
          fromFirestore: Catalogue.fromFirestore,
          toFirestore: (Catalogue catalogue, _) => catalogue.toFirestore(),
        )
        .snapshots()
        .listen((snapshot) {
      state = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> addCatalogue(Catalogue catalogue) async {
    final doc = db
        .collection('catalogues')
        .doc(); // Cambiado de 'catalogue' a 'catalogues'
    try {
      await doc.set(catalogue.toFirestore());
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteCatalogue(String id) async {
    try {
      await db
          .collection('catalogues')
          .doc(id)
          .delete(); // Cambiado de 'catalogue' a 'catalogues'
    } catch (e) {
      print(e);
    }
  }
}

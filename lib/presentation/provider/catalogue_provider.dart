import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/catalogue.dart';

final catalogueProvider =
    StateNotifierProvider<CatalogueNotifier, List<Catalogue>>(
  (ref) => CatalogueNotifier(FirebaseFirestore.instance),
);

class CatalogueNotifier extends StateNotifier<List<Catalogue>> {
  final FirebaseFirestore db;

  CatalogueNotifier(this.db) : super([]);

  Future<void> addCatalogue(Catalogue catalogue) async {
    final doc = db.collection('catalogue').doc();
    try {
      await doc.set(catalogue.toFirestore());
      state = [...state, catalogue];
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllCatalogues() async {
    final docs = db.collection('catalogue').withConverter(
        fromFirestore: Catalogue.fromFirestore,
        toFirestore: (Catalogue catalogue, _) => catalogue.toFirestore());
    final catalogues = await docs.get();
    state = [...state, ...catalogues.docs.map((d) => d.data())];
    print('Number of catalogues retrieved: ${catalogues.docs.length}');
  }
}

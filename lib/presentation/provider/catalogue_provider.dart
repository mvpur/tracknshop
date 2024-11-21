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
      await userReference.collection('catalogue').doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
}

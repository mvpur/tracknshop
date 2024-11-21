import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/presentation/provider/user_provider.dart';

final warehouseProvider =
    StateNotifierProvider<WarehouseNotifier, List<Warehouse>>(
  (ref) {
    final userNotifier = ref.read(userProvider.notifier);
    return WarehouseNotifier(userNotifier);
  },
);

class WarehouseNotifier extends StateNotifier<List<Warehouse>> {
  final UserNotifier userNotifier;
  WarehouseNotifier(this.userNotifier) : super([]) {
    _listenToWarehouses();
  }
  Future<void> _listenToWarehouses() async {
    final userReference = await userNotifier.getDocumentReference();
    userReference
        .collection('warehouse')
        .orderBy('date', descending: true)
        .withConverter(
          fromFirestore: Warehouse.fromFirestore,
          toFirestore: (Warehouse warehouse, _) => warehouse.toFirestore(),
        )
        .snapshots()
        .listen((snapshot) async {
      final warehouses = await Future.wait(snapshot.docs.map((doc) async {
        final warehouse = doc.data();
        await warehouse.loadCategories();
        return warehouse;
      }).toList());

      state = warehouses;
    });
  }

  Future<void> addWarehouse(Warehouse warehouse) async {
    final userReference = await userNotifier.getDocumentReference();
    final doc = userReference.collection('warehouse').doc();
    try {
      await doc.set(warehouse.toFirestore());
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteWarehouse(String id) async {
    final userReference = await userNotifier.getDocumentReference();
    try {
      await userReference.collection('warehouse').doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateWarehouseDate(String warehouseId) async {
    final userReference = await userNotifier.getDocumentReference();
    try {
      final warehouseDoc =
          userReference.collection('warehouse').doc(warehouseId);
      await warehouseDoc.update({'date': DateTime.now()});
    } catch (e) {
      print('Error updating warehouse date: $e');
    }
  }
}

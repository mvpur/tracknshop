import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/warehouse.dart';

final warehouseProvider =
    StateNotifierProvider<WarehouseNotifier, List<Warehouse>>(
  (ref) => WarehouseNotifier(FirebaseFirestore.instance),
);

class WarehouseNotifier extends StateNotifier<List<Warehouse>> {
  final FirebaseFirestore db;

  WarehouseNotifier(this.db) : super([]) {
    _listenToWarehouses();
  }

  void _listenToWarehouses() {
    db
        .collection('warehouse')
        .orderBy('date', descending: true)
        .withConverter(
          fromFirestore: Warehouse.fromFirestore,
          toFirestore: (Warehouse warehouse, _) => warehouse.toFirestore(),
        )
        .snapshots()
        .listen((snapshot) async {
      final warehouses = snapshot.docs.map((doc) => doc.data()).toList();

      for (var warehouse in warehouses) {
        await warehouse.loadItems();
        print("Loaded items for warehouse: ${warehouse.name}");
      }

      state = warehouses;
    });
  }

  Future<void> addWarehouse(Warehouse warehouse) async {
    final doc = db.collection('warehouse').doc();
    try {
      await doc.set(warehouse.toFirestore());
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteWarehouse(String id) async {
    try {
      await db.collection('warehouse').doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
}

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_shop_app/entities/warehouse.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Warehouse>> getAllWarehouses() async {
  List<Warehouse> warehouses = [];
  CollectionReference collectionReferenceWarehouse = db.collection('warehouse');

  QuerySnapshot queryWarehouse = await collectionReferenceWarehouse.get();

  for (var doc in queryWarehouse.docs) {
    var data = doc.data() as Map<String, dynamic>;
    print('WAREHOUSE PROVIDER: $data'); // Verifica qué datos estás obteniendo
    warehouses.add(Warehouse.fromMap(data));
  }

  return warehouses;
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/warehouse.dart';

final warehouseProvider =
    StateNotifierProvider<WarehouseNotifier, List<Warehouse>>(
  (ref) => WarehouseNotifier(FirebaseFirestore.instance),
);

class WarehouseNotifier extends StateNotifier<List<Warehouse>> {
  final FirebaseFirestore db;

  WarehouseNotifier(this.db) : super([]);

  Future<void> addWarehouse(Warehouse warehouse) async {
    final doc = db.collection('warehouse').doc();
    try {
      await doc.set(warehouse.toFirestore());
      state = [...state, warehouse];
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllWarehouses() async {
    final docs = db.collection('warehouse').withConverter(
        fromFirestore: Warehouse.fromFirestore,
        toFirestore: (Warehouse warehouse, _) => warehouse.toFirestore());
    final warehouses = await docs.get();
    state = [...state, ...warehouses.docs.map((d) => d.data())];
  }
}

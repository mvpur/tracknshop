import 'package:cloud_firestore/cloud_firestore.dart';
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

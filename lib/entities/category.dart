import 'package:cloud_firestore/cloud_firestore.dart';
import 'item.dart'; // Importar la clase Item

class Category {
  final String id;
  final String name;
  List<Item>? items; // Lista de Items en la Category

  Category({
    required this.id,
    required this.name,
    this.items,
  });

  // Crear una instancia de Category a partir de un Map
  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
      id: data['id'] ?? '',
      name: data['name'] ?? 'Sin Nombre',
    );
  }

  // Convertir Category a un Map para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
    };
  }

  // Factory para crear Category a partir de un documento Firestore
  factory Category.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = {...doc.data()!, "id": doc.id};
    return Category.fromMap(data);
  }

  // Método para cargar Items desde la subcolección 'Items' en Firestore
  Future<void> loadItems(String catalogueId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final itemsSnapshot = await firestore
        .collection('catalogue')
        .doc(catalogueId)
        .collection('category')
        .doc(id)
        .collection('items')
        .get();

    items = itemsSnapshot.docs.map((doc) {
      return Item.fromFirestore(
          doc.data() as DocumentSnapshot<Map<String, dynamic>>,
          doc.id as SnapshotOptions?);
    }).toList();
  }
}

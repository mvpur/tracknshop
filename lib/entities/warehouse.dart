import 'package:cloud_firestore/cloud_firestore.dart';

class Warehouse {
  String id;
  String icon;
  String name;
  DateTime date;

  Warehouse({
    required this.id,
    required this.icon,
    required this.name,
    required this.date,
  });

  // Método para crear una instancia de Warehouse desde un Map (por ejemplo, Firestore)
  factory Warehouse.fromMap(Map<String, dynamic> data) {
    return Warehouse(
      id: data['id'] ?? '', // Valor por defecto si el id es null
      icon: data['icon'] ??
          '', // Manejo de null: si el icon es null, usar un string vacío
      name: data['name'] ?? 'Sin Nombre', // Valor por defecto para el nombre
      date: (data['date'] != null && data['date'] is Timestamp)
          ? (data['date'] as Timestamp)
              .toDate() // Conversión de Timestamp a DateTime
          : DateTime.now(), // Fecha actual si el date es null
    );
  }

  // Método para convertir una instancia de Warehouse a un Map (para guardar en Firestore)
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'icon': icon,
      'name': name,
      'date': Timestamp.fromDate(date), // Convertimos DateTime a Timestamp
    };
  }

  // Método factory para la conversión desde un DocumentSnapshot de Firestore
  factory Warehouse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions?
        options, // Este argumento es necesario para cumplir la firma esperada
  ) {
    final data = {
      ...doc.data()!,
      "id":doc.id
    };
    return Warehouse.fromMap(data);
  }

  // Método para convertir Warehouse a Map (incluido para cumplir con la firma esperada)
  Map<String, dynamic> toFirestoreWithOptions(
    SetOptions?
        options, // Este argumento es necesario para cumplir la firma esperada
  ) {
    return toFirestore();
  }
}

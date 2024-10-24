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
}

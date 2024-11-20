import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  final String id;
  final String name;
  final String email;

  UserEntity({required this.id, required this.name, required this.email});

  factory UserEntity.fromMap(Map<String, dynamic> data) {
    return UserEntity(
        id: data['id'] ?? '',
        name: data['name'] ?? 'Sin Nombre',
        email: data['email'] ?? 'No email');
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory UserEntity.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = {...doc.data()!, "id": doc.id};
    return UserEntity.fromMap(data);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/user.dart';

final userProvider =
StateNotifierProvider<UserNotifier, List<User>>(
      (ref) => UserNotifier(FirebaseFirestore.instance),
);

class UserNotifier extends StateNotifier<List<User>> {
  final FirebaseFirestore db;
  UserNotifier(this.db) : super([]);

  Future<User?> register(String fullName, String emailAddress, String password) async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password
    );

    await credential.user?.updateDisplayName(fullName);

    await credential.user?.reload();
  logout();
    return credential.user;
  }

  Future<User?> login(String emailAddress, String password) async  {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password
    );
    return credential.user;

  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<DocumentReference<Map<String, dynamic>>> getDocumentReference() async {
    String? userUid =  await FirebaseAuth.instance.currentUser?.uid;
    return db.collection('users').doc(userUid);
  }
}

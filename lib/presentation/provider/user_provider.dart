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

  Future<void> register(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

  }

  Future<User?> login(String emailAddress, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password
    );
    return credential.user;

  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    DocumentReference doc = await getDocumentReference();
  }

  Future<DocumentReference<Map<String, dynamic>>> getDocumentReference() async {
    String? userUid =  await FirebaseAuth.instance.currentUser?.uid;
    return db.collection('users').doc(userUid);
  }
}

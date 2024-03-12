import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelpers {
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseAuth fireAuth = FirebaseAuth.instance;
  static final users = fireStore.collection("users").snapshots();

  static Future<void> addTextMessage({
    required String messageText,
    required String receiverId,
  }) async {}
}

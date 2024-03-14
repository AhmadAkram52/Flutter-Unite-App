import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireHelpers {
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseAuth fireAuth = FirebaseAuth.instance;

  static final currentUserId = fireAuth.currentUser?.uid;

  static final usersRef = fireStore.collection('Users');

  static final chatsRef = fireStore.collection('Chats');
}

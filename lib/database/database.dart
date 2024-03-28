import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class NotesDatabase {
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference posts =
  FirebaseFirestore.instance.collection('notes');

  Stream<QuerySnapshot> getPostStream() {
    final postStream = FirebaseFirestore.instance
        .collection('notes')
        .orderBy('timeStamp', descending: true)
        .snapshots();
    return postStream;
  }
}

class HistoryDatabase {
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference posts =
  FirebaseFirestore.instance.collection('userHistory');


  Stream<QuerySnapshot> getPostStream() {
    final postStream = FirebaseFirestore.instance
        .collection('userHistory')
        .orderBy('timeStamp', descending: true)
        .snapshots();
    return postStream;
  }
}

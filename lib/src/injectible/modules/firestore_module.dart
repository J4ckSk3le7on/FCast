import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreModule {
  final FirebaseApp firebaseApp;

  FirestoreModule(this.firebaseApp);

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseAuthModule {
  final FirebaseApp firebaseApp;

  FirebaseAuthModule(this.firebaseApp);

  FirebaseAuth get firebaseAuth {
    return FirebaseAuth.instance;
  }
}

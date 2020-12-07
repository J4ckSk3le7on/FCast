import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_cast/src/data/model/database/user.dart' as AppUser;
import 'package:f_cast/src/injectible/modules/firebase_auth_module.dart';
import 'package:f_cast/src/injectible/modules/firestore_module.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final _storePath = "/Users";

  UserRepository(FirestoreModule firestoreModule, FirebaseAuthModule authModule)
      : _firebaseAuth = authModule.firebaseAuth,
        _firestore = firestoreModule.firestore;

  Future<void> saveUser(AppUser.User user) async {
    var currentUser = _firebaseAuth.currentUser.uid;
    _firestore.collection(_storePath).doc(currentUser).set(user.toJson());
  }

  Future<AppUser.User> getUser() async {
    var currentUser = _firebaseAuth.currentUser.uid;
    var json =
        (await _firestore.collection(_storePath).doc(currentUser).get()).data();
    if (json == null || json.isEmpty) {
      return null;
    }
    return AppUser.User.fromJson(json);
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseRemoteConfigModule {
  final FirebaseApp firebaseApp;

  FirebaseRemoteConfigModule(this.firebaseApp);

  Future<RemoteConfig> get remoteConfig {
    return RemoteConfig.instance;
  }
}

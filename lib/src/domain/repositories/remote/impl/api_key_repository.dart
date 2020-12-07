import 'package:f_cast/src/injectible/modules/firebase_remote_config_module.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton()
class ApiKeyRepository {
  final RemoteConfig remoteConfig;
  final SharedPreferences sharedPreferences;
  final _apiKeyKey = "ApiKey";

  @factoryMethod
  static Future<ApiKeyRepository> createAsync(
      FirebaseRemoteConfigModule firebaseRemoteConfigModule,
      SharedPreferences sharedPreferences) async {
    var remoteConfig = await firebaseRemoteConfigModule.remoteConfig;
    return ApiKeyRepository(remoteConfig, sharedPreferences);
  }

  ApiKeyRepository(this.remoteConfig, this.sharedPreferences);

  Future<String> getApiKey() async {
    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
    var apiKey = remoteConfig.getString(_apiKeyKey);
    if (apiKey != null) {
      _saveApiKey(apiKey);
      return apiKey;
    } else {
      return _getSavedApiKey();
    }
  }

  Future<void> _saveApiKey(String apiKey) async {
    sharedPreferences.setString(_apiKeyKey, apiKey);
  }

  String _getSavedApiKey() {
    return sharedPreferences.getString(_apiKeyKey);
  }
}

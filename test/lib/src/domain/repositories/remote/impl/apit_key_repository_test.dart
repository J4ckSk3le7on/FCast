import 'dart:async';

import 'package:f_cast/src/domain/repositories/remote/impl/api_key_repository.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockRemoteConfig extends Mock implements RemoteConfig {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockRemoteConfig mockRemoteConfig;
  MockSharedPreferences mockSharedPreferences;
  ApiKeyRepository apiKeyRepository;

  setUp(() {
    mockRemoteConfig = MockRemoteConfig();
    mockSharedPreferences = MockSharedPreferences();
    apiKeyRepository =
        ApiKeyRepository(mockRemoteConfig, mockSharedPreferences);
    when(mockRemoteConfig.fetch())
        .thenAnswer((realInvocation) => Future.value(null));
    when(mockRemoteConfig.activateFetched())
        .thenAnswer((realInvocation) => Future.value(null));
  });

  group("get api key", () {
    test("When api key is found by remote config, it's cached and returned",
        () async {
      //arrange
      var apiKey = "TestKey";
      when(mockRemoteConfig.getString(any)).thenReturn(apiKey);

      //act
      var result = await apiKeyRepository.getApiKey();

      //assert
      expect(result, apiKey);
      verify(mockSharedPreferences.setString(any, apiKey)).called(1);
    });

    test(
        "When api key is not found in remote config, the cached value is returned",
        () async {
      //arrange
      var apiKey = "TestKey";
      when(mockRemoteConfig.getString(any)).thenReturn(null);
      when(mockSharedPreferences.getString(any)).thenReturn(apiKey);

      //act
      var result = await apiKeyRepository.getApiKey();

      //assert
      expect(result, apiKey);
      verify(mockSharedPreferences.getString(any)).called(1);
    });
  });
}

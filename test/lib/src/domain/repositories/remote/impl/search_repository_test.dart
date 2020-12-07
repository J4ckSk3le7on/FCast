import 'package:dio/dio.dart';
import 'package:f_cast/src/domain/repositories/remote/impl/search_repository.dart';
import 'package:f_cast/src/injectible/modules/dio_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDioModule extends Mock implements DioModule {}

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  MockDioModule mockDioModule;
  MockDio mockDio;
  MockResponse mockResponse;
  SearchRepository searchRepository;
  Map<String, dynamic> successfulResultBody = {
    "results": [
      {
        "id": "TestId",
        "description_original": "test",
        "thumbnail": "test",
        "title_original": "test",
        "total_episodes": 1
      },
    ]
  };

  setUp(() {
    mockDioModule = MockDioModule();
    mockDio = MockDio();
    when(mockDioModule.dio).thenReturn(mockDio);
    searchRepository = SearchRepository(mockDioModule);
    mockResponse = MockResponse();
  });

  group("Get search string", () {
    test("when get search is successful, results are returned", () async {
      //arrange
      when(mockDio.get(any, queryParameters: anyNamed("queryParameters")))
          .thenAnswer((realInvocation) => Future.value(mockResponse));
      when(mockResponse.statusCode).thenReturn(200);
      when(mockResponse.data).thenReturn(successfulResultBody);

      //act
      var results = await searchRepository.searchForPodcast("test");

      //assert
      expect(results, isNotNull);
      expect(results.results, isNotEmpty);
    });

    test("when get search not is successful, empty results are returned",
        () async {
      //arrange
      when(mockDio.get(any, queryParameters: anyNamed("queryParameters")))
          .thenAnswer((realInvocation) => Future.value(mockResponse));
      when(mockResponse.statusCode).thenReturn(400);

      //act
      var results = await searchRepository.searchForPodcast("test");

      //assert
      expect(results, isNotNull);
      expect(results.results, isEmpty);
    });

    test("when get search throws an exception, empty results are returned",
        () async {
      //arrange
      when(mockDio.get(any, queryParameters: anyNamed("queryParameters")))
          .thenThrow(DioError());

      //act
      var results = await searchRepository.searchForPodcast("test");

      //assert
      expect(results, isNotNull);
      expect(results.results, isEmpty);
    });
  });
}

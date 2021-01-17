import 'package:dio/dio.dart';
import 'package:f_cast/src/data/model/api/curated_podcasts/curated_podcasts.dart';
import 'package:f_cast/src/domain/repositories/remote/impl/curated_podcast_repository.dart';
import 'package:f_cast/src/injectible/modules/dio_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDioModule extends Mock implements DioModule {}

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  MockDio mockDio;
  MockDioModule mockDioModule;
  MockResponse mockResponse;
  CuratedPodcastRepository curatedPodcastRepository;

  setUp(() {
    mockDio = MockDio();
    mockDioModule = MockDioModule();
    when(mockDioModule.dio).thenReturn(mockDio);
    mockResponse = MockResponse();
    when(mockDio.get(any)).thenAnswer((_) => Future.value(mockResponse));
    curatedPodcastRepository = CuratedPodcastRepository(mockDioModule);
  });

  group("Get podcast curations", () {
    test("When get request is successful, CuratedPodcasts is returned",
        () async {
      //arrange
      when(mockResponse.statusCode).thenReturn(200);
      var successPodcastResponse = CuratedPodcasts([]);
      when(mockResponse.data).thenReturn(successPodcastResponse.toJson());

      //act
      var result = await curatedPodcastRepository.getCuratedPodcasts();

      //assert
      expect(result, successPodcastResponse);
    });

    test("When get request fails, empty results is returned", () async {
      //arrange
      when(mockResponse.statusCode).thenReturn(400);

      //act
      var result = await curatedPodcastRepository.getCuratedPodcasts();

      //assert
      expect(result, CuratedPodcasts([]));
    });

    test("When dio throws an error, empty results is returned", () async {
      //arrange
      when(mockDio.get(any)).thenThrow(DioError());

      //act
      var result = await curatedPodcastRepository.getCuratedPodcasts();

      //assert
      expect(result, CuratedPodcasts([]));
    });
  });
}

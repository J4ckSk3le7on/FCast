import 'package:f_cast/src/data/model/api/search/search_results.dart';
import 'package:f_cast/src/data/services/impl/search_service.dart';
import 'package:f_cast/src/domain/repositories/remote/impl/search_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSearchRepository extends Mock implements SearchRepository {}

void main() {
  MockSearchRepository mockSearchRepository;
  SearchService searchService;

  setUp(() {
    mockSearchRepository = MockSearchRepository();
    searchService = SearchService(mockSearchRepository);
  });

  group("Search for podcast", () {
    test("When search for podcast is called, it's passed to the repository",
        () async {
      //arrange
      var searchResult = SearchPodcastResults([]);
      var searchString = "test";
      when(mockSearchRepository.searchForPodcast(searchString))
          .thenAnswer((realInvocation) => Future.value(searchResult));

      //act
      var result = await searchService.searchPodcast(searchString);

      //assert
      expect(result, searchResult);
      verify(mockSearchRepository.searchForPodcast(searchString)).called(1);
    });
  });
}

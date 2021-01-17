import 'package:bloc_test/bloc_test.dart';
import 'package:f_cast/src/data/model/api/search/search_results.dart';
import 'package:f_cast/src/data/services/impl/search_service.dart';
import 'package:f_cast/src/ui/home/search/cubit/search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSearchService extends Mock implements SearchService {}

void main() {
  MockSearchService mockSearchService;
  SearchPodcastResults results = SearchPodcastResults([]);
  setUp(() {
    mockSearchService = MockSearchService();
    when(mockSearchService.searchPodcast(any))
        .thenAnswer((realInvocation) => Future.value(results));
  });

  group("Search for podcasts", () {
    blocTest(
      "When search is called, results are emitted",
      build: () => SearchCubit(mockSearchService),
      act: (SearchCubit cubit) => cubit.searchPodcast("Test Search"),
      expect: [SearchState.loading(), SearchState.loaded(results)],
    );
  });
}

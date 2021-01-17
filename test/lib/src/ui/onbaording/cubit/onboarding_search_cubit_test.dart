import 'package:bloc_test/bloc_test.dart';
import 'package:f_cast/src/data/model/api/search/search_results.dart';
import 'package:f_cast/src/data/services/impl/search_service.dart';
import 'package:f_cast/src/ui/onboarding/cubit/onboarding_search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSearchService extends Mock implements SearchService {}

void main() {
  MockSearchService mockSearchService;
  SearchPodcastResults successfulResults = SearchPodcastResults(
    [
      PodcastResults(
          "id", "descriptionOriginal", "thumbnail", "titleOriginal", 1)
    ],
  );
  SearchPodcastResults emptyResults = SearchPodcastResults([]);

  setUp(() {
    mockSearchService = MockSearchService();
  });

  group("Search results", () {
    blocTest(
      "When searching, [loading, loaded] is emitted",
      build: () {
        when(mockSearchService.searchPodcast(any))
            .thenAnswer((realInvocation) => Future.value(successfulResults));
        return OnboardingSearchCubit(mockSearchService);
      },
      act: (OnboardingSearchCubit cubit) => cubit.search("test"),
      expect: [
        OnboardingSearchState.loading(),
        OnboardingSearchState.loaded(successfulResults, []),
      ],
    );
    blocTest(
      "When searching and an empty result is given, [loading, loaded] is emitted",
      build: () {
        when(mockSearchService.searchPodcast(any))
            .thenAnswer((realInvocation) => Future.value(emptyResults));
        return OnboardingSearchCubit(mockSearchService);
      },
      act: (OnboardingSearchCubit cubit) => cubit.search("test"),
      expect: [
        OnboardingSearchState.loading(),
        OnboardingSearchState.empty(),
      ],
    );
  });

  group("Add subscriptions", () {
    blocTest(
      "When adding to subscription, it's emitted",
      build: () {
        return OnboardingSearchCubit(mockSearchService);
      },
      act: (OnboardingSearchCubit cubit) => cubit.toggleId("test"),
      expect: [
        OnboardingSearchState.loading(),
        OnboardingSearchState.loaded(SearchPodcastResults([]), ["test"])
      ],
    );
    blocTest(
      "When removing to subscription, it's not emitted",
      build: () {
        var cubit = OnboardingSearchCubit(mockSearchService);
        cubit.toggleId("test");
        return cubit;
      },
      act: (OnboardingSearchCubit cubit) {
        cubit.toggleId("test");
      },
      expect: [
        OnboardingSearchState.loading(),
        OnboardingSearchState.loaded(SearchPodcastResults([]), []),
      ],
    );
  });
}

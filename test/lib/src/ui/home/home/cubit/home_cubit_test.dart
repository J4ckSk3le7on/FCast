import 'package:bloc_test/bloc_test.dart';
import 'package:f_cast/src/data/model/api/curated_podcasts.dart';
import 'package:f_cast/src/data/services/impl/curated_podcast_service.dart';
import 'package:f_cast/src/ui/home/home/cubit/home_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCuratedPodcastService extends Mock implements CuratedPodcastService {}

void main() {
  MockCuratedPodcastService mockCuratedPodcastService =
      MockCuratedPodcastService();
  CuratedPodcasts mockPodcasts = CuratedPodcasts([]);

  setUp(() {
    when(mockCuratedPodcastService.getCuratedPodcasts())
        .thenAnswer((realInvocation) => Future.value(mockPodcasts));
  });

  group("init", () {
    blocTest("when cubit is initialized, podcasts are fetched",
        build: () => HomeCubit(mockCuratedPodcastService),
        expect: [HomeState.loaded(mockPodcasts)]);
  });

  group("refresh", () {
    blocTest(
      "When cubit is refreshed, podcasts are fetched",
      build: () => HomeCubit(mockCuratedPodcastService),
      act: (HomeCubit cubit) => cubit.refresh(),
      expect: [
        HomeState.loading(),
        HomeState.loaded(mockPodcasts),
      ],
    );
  });
}

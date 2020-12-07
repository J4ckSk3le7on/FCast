part of 'onboarding_search_cubit.dart';

@freezed
abstract class OnboardingSearchState with _$OnboardingSearchState {
  factory OnboardingSearchState.loading() = _Loading;
  factory OnboardingSearchState.empty() = _Empty;
  factory OnboardingSearchState.loaded(
      SearchPodcastResults results, List<String> selectedIds) = _Loaded;
}

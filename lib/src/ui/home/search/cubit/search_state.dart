part of 'search_cubit.dart';

@freezed
abstract class SearchState with _$SearchState {
  factory SearchState.loading() = _Loading;
  factory SearchState.loaded(SearchPodcastResults results) = _Loaded;
}

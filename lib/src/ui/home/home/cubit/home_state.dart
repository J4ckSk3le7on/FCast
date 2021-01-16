part of 'home_cubit.dart';

@freezed
abstract class HomeState with _$HomeState {
  factory HomeState.loading() = _Loading;
  factory HomeState.loaded(CuratedPodcasts curatedPodcasts) = _Loaded;
}

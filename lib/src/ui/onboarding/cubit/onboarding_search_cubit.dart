import 'package:f_cast/src/data/model/api/search_results.dart';
import 'package:f_cast/src/data/services/impl/search_service.dart';
import 'package:f_cast/src/domain/repositories/remote/impl/search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_search_cubit.freezed.dart';
part 'onboarding_search_state.dart';

@Singleton(dependsOn: [SearchRepository])
class OnboardingSearchCubit extends Cubit<OnboardingSearchState> {
  final SearchService _searchService;
  List<String> _selectedIds = [];
  SearchPodcastResults _results = SearchPodcastResults([]);

  OnboardingSearchCubit(this._searchService)
      : super(OnboardingSearchState.empty());

  Future<void> search(String searchString) async {
    emit(OnboardingSearchState.loading());
    _results = await _searchService.searchPodcast(searchString);
    if (_results.results.isEmpty) {
      emit(OnboardingSearchState.empty());
    } else {
      emit(OnboardingSearchState.loaded(_results, _selectedIds));
    }
  }

  void toggleId(String id) {
    emit(OnboardingSearchState.loading());
    if (_selectedIds.contains(id)) {
      _selectedIds.remove(id);
    } else {
      _selectedIds.add(id);
    }
    emit(OnboardingSearchState.loaded(_results, _selectedIds));
  }
}

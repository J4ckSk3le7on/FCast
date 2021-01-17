import 'package:f_cast/src/data/model/api/search/search_results.dart';
import 'package:f_cast/src/data/services/impl/search_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'search_cubit.freezed.dart';
part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchService _searchService;
  SearchCubit(this._searchService)
      : super(SearchState.loaded(SearchPodcastResults([])));

  Future<void> searchPodcast(String searchString) async {
    if (searchString.isEmpty) {
      emit(SearchState.loaded(SearchPodcastResults([])));
      return;
    }
    emit(SearchState.loading());
    var results = await _searchService.searchPodcast(searchString);
    emit(SearchState.loaded(results));
  }
}

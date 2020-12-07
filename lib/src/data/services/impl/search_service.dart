import 'package:f_cast/src/data/model/api/search_results.dart';
import 'package:f_cast/src/domain/repositories/remote/impl/search_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchService {
  final SearchRepository _searchRepository;

  SearchService(this._searchRepository);

  Future<SearchPodcastResults> searchPodcast(String search) =>
      _searchRepository.searchForPodcast(search);
}

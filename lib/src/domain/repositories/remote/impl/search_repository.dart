import 'package:dio/dio.dart';
import 'package:f_cast/src/data/model/api/search_results.dart';
import 'package:f_cast/src/extensions/results_extension.dart';
import 'package:f_cast/src/injectible/modules/dio_module.dart';
import 'package:injectable/injectable.dart';

@Singleton(dependsOn: [DioModule])
class SearchRepository {
  final Dio _dio;
  final _searchPath = "/search";

  SearchRepository(DioModule _dioModule) : _dio = _dioModule.dio;

  Future<SearchPodcastResults> searchForPodcast(String searchString) async {
    try {
      var result = await _dio.get(_searchPath, queryParameters: {
        "q": searchString,
        "type": "podcast",
      });
      if (result.isSuccessful()) {
        return SearchPodcastResults.fromJson(
            {"results": result.data["results"]});
      }
    } catch (e) {
      return SearchPodcastResults([]);
    }
    return SearchPodcastResults([]);
  }
}

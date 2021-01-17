import 'package:dio/dio.dart';
import 'package:f_cast/src/data/model/api/curated_podcasts/curated_podcasts.dart';
import 'package:f_cast/src/extensions/results_extension.dart';
import 'package:injectable/injectable.dart';

import '../../../../injectible/modules/dio_module.dart';

@injectable
class CuratedPodcastRepository {
  final Dio _dio;
  final String _uriPath = "/curated_podcasts";

  CuratedPodcastRepository(DioModule dioModule) : _dio = dioModule.dio;

  Future<CuratedPodcasts> getCuratedPodcasts() async {
    try {
      var response = await _dio.get(_uriPath);
      if (!response.isSuccessful()) {
        return CuratedPodcasts([]);
      }
      var data = response.data as Map<String, dynamic>;
      return CuratedPodcasts.fromJson(data);
    } catch (e) {
      print(e);
    }
    return CuratedPodcasts([]);
  }
}

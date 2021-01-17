import 'package:f_cast/src/data/model/api/curated_podcasts/curated_podcasts.dart';
import 'package:f_cast/src/domain/repositories/remote/impl/curated_podcast_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CuratedPodcastService {
  final CuratedPodcastRepository _curatedPodcastRepository;

  CuratedPodcastService(this._curatedPodcastRepository);

  Future<CuratedPodcasts> getCuratedPodcasts() =>
      _curatedPodcastRepository.getCuratedPodcasts();
}

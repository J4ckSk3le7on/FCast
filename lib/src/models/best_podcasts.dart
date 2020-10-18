import 'package:f_cast/src/models/podcast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'best_podcasts.freezed.dart';
part 'best_podcasts.g.dart';

@freezed
abstract class BestPodcasts with _$BestPodcasts {
  factory BestPodcasts(
    int id,
    String name,
    int total,
    List<Podcast> podcasts,
    int pageNumber,
    int nextPageNumber,
    int previousPageNumber,
  ) = _BestPodcasts;

  factory BestPodcasts.fromJson(Map<String, dynamic> json) =>
      _$BestPodcastsFromJson(json);
}

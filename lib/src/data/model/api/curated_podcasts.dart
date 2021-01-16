import 'package:freezed_annotation/freezed_annotation.dart';

import 'curated_podcast.dart';

part 'curated_podcasts.freezed.dart';
part 'curated_podcasts.g.dart';

@freezed
abstract class CuratedPodcasts with _$CuratedPodcasts {
  factory CuratedPodcasts(
      @JsonKey(name: "curated_lists")
          List<CuratedPodcast> curatedPodcasts) = _CuratedPodcasts;
  factory CuratedPodcasts.fromJson(Map<String, dynamic> json) =>
      _$CuratedPodcastsFromJson(json);
}

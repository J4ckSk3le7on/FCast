import 'package:freezed_annotation/freezed_annotation.dart';

import 'episode.dart';

part 'podcast.freezed.dart';
part 'podcast.g.dart';

@freezed
abstract class Podcast with _$Podcast {
  factory Podcast(
    String id,
    String type,
    String image,
    String title,
    String country,
    String website,
    List<Episode> episodes,
    String language,
    List<int> genreIds,
    String thumbnail,
  ) = _Podcast;

  factory Podcast.fromJson(Map<String, dynamic> json) =>
      _$PodcastFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode.freezed.dart';
part 'episode.g.dart';

@freezed
abstract class Episode with _$Episode {
  factory Episode(
    String id,
    String link,
    String audio,
    String image,
    String title,
    String thumbnail,
    String description,
    DateTime pubDateMs,
    int audioLengthSec,
  ) = _Episode;

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
}

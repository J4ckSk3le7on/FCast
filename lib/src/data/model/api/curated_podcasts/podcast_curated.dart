import 'package:freezed_annotation/freezed_annotation.dart';

part 'podcast_curated.freezed.dart';
part 'podcast_curated.g.dart';

@freezed
abstract class PodcastCurated with _$PodcastCurated {
  factory PodcastCurated(
          String id, String image, String title, @nullable String description) =
      _PodcastCurated;
  factory PodcastCurated.fromJson(Map<String, dynamic> json) =>
      _$PodcastCuratedFromJson(json);
}

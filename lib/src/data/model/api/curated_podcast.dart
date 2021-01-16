import 'package:f_cast/src/data/model/api/podcast_curated.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/podcast.dart';

part 'curated_podcast.freezed.dart';
part 'curated_podcast.g.dart';

@freezed
abstract class CuratedPodcast with _$CuratedPodcast {
  factory CuratedPodcast(
    String title,
    String description,
    List<PodcastCurated> podcasts,
  ) = _CuratedPodcast;

  factory CuratedPodcast.fromJson(Map<String, dynamic> json) =>
      _$CuratedPodcastFromJson(json);
}

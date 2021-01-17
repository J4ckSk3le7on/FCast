import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_results.freezed.dart';
part 'search_results.g.dart';

@freezed
abstract class SearchPodcastResults with _$SearchPodcastResults {
  factory SearchPodcastResults(List<PodcastResults> results) =
      _SearchPodcastResults;
  factory SearchPodcastResults.fromJson(Map<String, dynamic> json) =>
      _$SearchPodcastResultsFromJson(json);
}

@freezed
abstract class PodcastResults with _$PodcastResults {
  factory PodcastResults(
    String id,
    @JsonKey(name: "description_original") String descriptionOriginal,
    String thumbnail,
    @JsonKey(name: "title_original") String titleOriginal,
    @JsonKey(name: "total_episodes") int totalEpisodes,
  ) = _PodcastResults;
  factory PodcastResults.fromJson(Map<String, dynamic> json) =>
      _$PodcastResultsFromJson(json);
}

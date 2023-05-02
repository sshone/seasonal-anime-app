import 'package:json_annotation/json_annotation.dart';

import 'aired.dart';
import 'broadcast.dart';
import 'demographic.dart';
import 'genre.dart';
import 'images.dart';
import 'licensor.dart';
import 'producer.dart';
import 'studio.dart';
import 'theme.dart';
import 'title.dart';
import 'trailer.dart';

part 'anime.g.dart';

@JsonSerializable()
class AnimeDTO {
  @JsonKey(name: 'mal_id')
  final int malId;
  @JsonKey(name: 'url')
  final String url;
  @JsonKey(name: 'images')
  final ImagesDTO images;
  @JsonKey(name: 'trailer')
  final TrailerDTO? trailer;
  @JsonKey(name: 'approved')
  final bool approved;
  @JsonKey(name: 'titles')
  final List<TitleDTO> titles;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'title_english')
  final String? titleEnglish;
  @JsonKey(name: 'title_japanese')
  final String? titleJapanese;
  @JsonKey(name: 'title_synonyms')
  final List<String>? titleSynonyms;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'source')
  final String source;
  @JsonKey(name: 'episodes')
  final int? episodes;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'airing')
  final bool airing;
  @JsonKey(name: 'aired')
  final AiredDTO aired;
  @JsonKey(name: 'duration')
  final String? duration;
  @JsonKey(name: 'rating')
  final String? rating;
  @JsonKey(name: 'score')
  final double? score;
  @JsonKey(name: 'scored_by')
  final int? scoredBy;
  @JsonKey(name: 'rank')
  final int? rank;
  @JsonKey(name: 'popularity')
  final int? popularity;
  @JsonKey(name: 'members')
  final int members;
  @JsonKey(name: 'favorites')
  final int favorites;
  @JsonKey(name: 'synopsis')
  final String? synopsis;
  @JsonKey(name: 'background')
  final String? background;
  @JsonKey(name: 'season')
  final String? season;
  @JsonKey(name: 'year')
  final int? year;
  @JsonKey(name: 'broadcast')
  final BroadcastDTO broadcast;
  @JsonKey(name: 'producers')
  final List<ProducerDTO>? producers;
  @JsonKey(name: 'licensors')
  final List<LicensorDTO>? licensors;
  @JsonKey(name: 'studios')
  final List<StudioDTO>? studios;
  @JsonKey(name: 'genres')
  final List<GenreDTO>? genres;
  @JsonKey(name: 'explicit_genres')
  final List<GenreDTO>? explicitGenres;
  @JsonKey(name: 'themes')
  final List<ThemeDTO>? themes;
  @JsonKey(name: 'demographics')
  final List<DemographicDTO>? demographics;

  AnimeDTO({
    required this.malId,
    required this.url,
    required this.images,
    required this.trailer,
    required this.approved,
    required this.titles,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.titleSynonyms,
    required this.type,
    required this.source,
    required this.episodes,
    required this.status,
    required this.airing,
    required this.aired,
    required this.duration,
    required this.rating,
    required this.score,
    required this.scoredBy,
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.synopsis,
    required this.background,
    required this.season,
    required this.year,
    required this.broadcast,
    required this.producers,
    required this.licensors,
    required this.studios,
    required this.genres,
    required this.explicitGenres,
    required this.themes,
    required this.demographics,
  });

  factory AnimeDTO.fromJson(Map<String, dynamic> json) =>
      _$AnimeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AnimeDTOToJson(this);
}

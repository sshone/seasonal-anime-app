class Anime {
  final int malId;
  final String title;
  final TitleDetails? titleDetails;
  final List<String>? titleSynonyms;
  final List<Genre>? genres;
  final ImageUrls imageUrls;
  final String? synopsis;
  final AnimeDetails? details;
  final AiringSchedule? airingSchedule;
  final Scores? scores;
  final int? members;
  final int? favorites;

  Anime({
    required this.malId,
    required this.title,
    this.titleDetails,
    this.titleSynonyms,
    this.genres,
    required this.imageUrls,
    this.synopsis,
    this.details,
    this.airingSchedule,
    this.scores,
    this.members,
    this.favorites,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      malId: json['mal_id'],
      title: json['title'],
      titleDetails: json.containsKey('title_english') ||
              json.containsKey('title_japanese')
          ? TitleDetails(
              titleEnglish: json['title_english'],
              titleJapanese: json['title_japanese'],
            )
          : null,
      titleSynonyms: List<String>.from(json['title_synonyms'] ?? []),
      genres: json.containsKey('genres')
          ? List<Genre>.from(
              json['genres']
                  .map((x) => Genre.fromJson(x as Map<String, dynamic>)),
            )
          : null,
      imageUrls: ImageUrls.fromJson(json['images']),
      synopsis: json['synopsis'],
      details: json.containsKey('type') ||
              json.containsKey('episodes') ||
              json.containsKey('status') ||
              json.containsKey('duration') ||
              json.containsKey('rating')
          ? AnimeDetails(
              type: json['type'],
              episodes: json['episodes'],
              status: json['status'],
              duration: json['duration'],
              rating: json['rating'],
            )
          : null,
      airingSchedule: json.containsKey('aired')
          ? AiringSchedule(
              airingStart: json['aired']['from'],
              airingEnd: json['aired']['to'],
            )
          : null,
      scores: json.containsKey('score') ||
              json.containsKey('scored_by') ||
              json.containsKey('rank') ||
              json.containsKey('popularity')
          ? Scores(
              score: json['score']?.toDouble(),
              scoredBy: json['scored_by'],
              rank: json['rank'],
              popularity: json['popularity'],
            )
          : null,
      members: json['members'],
      favorites: json['favorites'],
    );
  }
}

class TitleDetails {
  final String? titleEnglish;
  final String? titleJapanese;

  TitleDetails({
    this.titleEnglish,
    this.titleJapanese,
  });
}

class Genre {
  final int malId;
  final String name;

  Genre({
    required this.malId,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      malId: json['mal_id'],
      name: json['name'],
    );
  }
}

class ImageUrls {
  final String imageUrl;
  final String? largeImageUrl;
  final String? smallImageUrl;

  ImageUrls({
    required this.imageUrl,
    this.largeImageUrl,
    this.smallImageUrl,
  });

  factory ImageUrls.fromJson(Map<String, dynamic> json) {
    return ImageUrls(
      imageUrl: json['jpg']['image_url'],
      largeImageUrl: json['jpg']['large_image_url'],
      smallImageUrl: json['jpg']['small_image_url'],
    );
  }
}

class AnimeDetails {
  final String? type;
  final int? episodes;
  final String? status;
  final String? duration;
  final String? rating;

  AnimeDetails({
    this.type,
    this.episodes,
    this.status,
    this.duration,
    this.rating,
  });
}

class AiringSchedule {
  final String? airingStart;
  final String? airingEnd;

  AiringSchedule({
    this.airingStart,
    this.airingEnd,
  });
}

class Scores {
  final double? score;
  final int? scoredBy;
  final int? rank;
  final int? popularity;

  Scores({
    this.score,
    this.scoredBy,
    this.rank,
    this.popularity,
  });
}

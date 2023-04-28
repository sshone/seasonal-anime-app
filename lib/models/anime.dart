class Anime {
  final int malId;
  final String title;
  final String titleEnglish;
  final String titleJapanese;
  final List<String> titleSynonyms;
  final List<String> genres;
  final String imageUrl;
  final String synopsis;
  final String type;
  final int episodes;
  final String status;
  final String airingStart;
  final String airingEnd;
  final String duration;
  final String rating;
  final double score;
  final int scoredBy;
  final int rank;
  final int popularity;
  final int members;
  final int favorites;

  Anime({
    required this.malId,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.titleSynonyms,
    required this.genres,
    required this.imageUrl,
    required this.synopsis,
    required this.type,
    required this.episodes,
    required this.status,
    required this.airingStart,
    required this.airingEnd,
    required this.duration,
    required this.rating,
    required this.score,
    required this.scoredBy,
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      malId: json['mal_id'],
      title: json['title'],
      titleEnglish: json['title_english'] ?? '',
      titleJapanese: json['title_japanese'] ?? '',
      titleSynonyms: List<String>.from(json['title_synonyms']),
      genres: List<String>.from(json['genres'].map((x) => x['name'])),
      imageUrl: json['images']['jpg']['small_image_url'],
      synopsis: json['synopsis'],
      type: json['type'],
      episodes: json['episodes'],
      status: json['status'],
      airingStart: json['aired']['from'],
      airingEnd: json['aired']['to'],
      duration: json['duration'],
      rating: json['rating'],
      score: json['score'].toDouble(),
      scoredBy: json['scored_by'],
      rank: json['rank'],
      popularity: json['popularity'],
      members: json['members'],
      favorites: json['favorites'],
    );
  }
}

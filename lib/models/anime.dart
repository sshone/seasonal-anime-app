import 'DTO/anime.dart';
import 'DTO/genre.dart';

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
  final Trailer? trailer;
  final Broadcast? broadcast;
  final List<Studio>? studios;
  final List<Producer>? producers;
  final List<Licensor>? licensors;
  final List<ExplicitGenre>? explicitGenres;
  final List<Theme>? themes;
  final List<Demographic>? demographics;
  final String? background;

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
    this.trailer,
    this.broadcast,
    this.studios,
    this.producers,
    this.licensors,
    this.explicitGenres,
    this.themes,
    this.demographics,
    this.background,
  });

  factory Anime.fromDTO(AnimeDTO dto) {
    return Anime(
      malId: dto.malId,
      title: dto.title,
      titleDetails: TitleDetails(
        titleEnglish: dto.titleEnglish,
        titleJapanese: dto.titleJapanese,
      ),
      titleSynonyms: dto.titleSynonyms,
      genres: dto.genres?.map((genreDTO) => Genre.fromDTO(genreDTO)).toList(),
      imageUrls: ImageUrls(
        imageUrl: dto.images.jpg.imageUrl,
        largeImageUrl: dto.images.jpg.largeImageUrl,
      ),
      synopsis: dto.synopsis,
      details: dto.type != null ||
              dto.episodes != null ||
              dto.status != null ||
              dto.duration != null ||
              dto.rating != null ||
              dto.season != null ||
              dto.year != null
          ? AnimeDetails(
              type: dto.type,
              episodes: dto.episodes,
              status: dto.status,
              duration: dto.duration,
              rating: dto.rating,
              season: dto.season,
              year: dto.year,
            )
          : null,
      airingSchedule: dto.aired.from != null || dto.aired.to != null
          ? AiringSchedule(
              airingStart: dto.aired.from,
              airingEnd: dto.aired.to,
            )
          : null,
      scores: dto.score != null ||
              dto.scoredBy != null ||
              dto.rank != null ||
              dto.popularity != null
          ? Scores(
              score: dto.score,
              scoredBy: dto.scoredBy,
              rank: dto.rank,
              popularityRank: dto.popularity,
            )
          : null,
      members: dto.members,
      favorites: dto.favorites,
      trailer: dto.trailer?.youtubeId != null
          ? Trailer(
              youtubeId: dto.trailer?.youtubeId,
              url: dto.trailer?.url,
              embedUrl: dto.trailer?.embedUrl,
            )
          : null,
      broadcast: dto.broadcast.day != null ||
              dto.broadcast.time != null ||
              dto.broadcast.timezone != null
          ? Broadcast(
              day: dto.broadcast.day,
              time: dto.broadcast.time,
              timezone: dto.broadcast.timezone,
            )
          : null,
      studios: dto.studios != null
          ? dto.studios!
              .map((studioDTO) => Studio(
                  name: studioDTO.name,
                  type: studioDTO.type,
                  url: studioDTO.url))
              .toList()
          : null,
      producers: dto.producers != null
          ? dto.producers!
              .map((producerDTO) => Producer(
                  name: producerDTO.name,
                  type: producerDTO.type,
                  url: producerDTO.url))
              .toList()
          : null,
      licensors: dto.licensors != null
          ? dto.licensors
              ?.map((licensor) => Licensor(
                  name: licensor.name, type: licensor.type, url: licensor.url))
              .toList()
          : null,
      explicitGenres: dto.explicitGenres != null
          ? dto.explicitGenres!
              .map((explicitGenre) => ExplicitGenre(
                  name: explicitGenre.name,
                  type: explicitGenre.type,
                  url: explicitGenre.url))
              .toList()
          : null,
      themes: dto.themes != null
          ? dto.themes
              ?.map((themeDTO) => Theme(
                  name: themeDTO.name, type: themeDTO.type, url: themeDTO.url))
              .toList()
          : null,
      demographics: dto.demographics != null
          ? dto.demographics!
              .map((demographicDTO) => Demographic(
                  name: demographicDTO.name,
                  type: demographicDTO.type,
                  url: demographicDTO.url))
              .toList()
          : null,
      background: dto.background,
    );
  }
}

class TitleDetails {
  final String? titleEnglish;
  final String? titleJapanese;

  TitleDetails({this.titleEnglish, this.titleJapanese});
}

class Genre {
  final int malId;
  final String name;
  final String? type;
  final String? url;

  Genre({
    required this.malId,
    required this.name,
    this.type,
    this.url,
  });

  factory Genre.fromDTO(GenreDTO dto) {
    return Genre(
      malId: dto.malId,
      name: dto.name,
      type: dto.type,
      url: dto.url,
    );
  }
}

class ImageUrls {
  final String imageUrl;
  final String? largeImageUrl;

  ImageUrls({
    required this.imageUrl,
    this.largeImageUrl,
  });
}

class AnimeDetails {
  final String? type;
  final int? episodes;
  final String? status;
  final String? duration;
  final String? rating;
  final String? season;
  final int? year;

  AnimeDetails({
    this.type,
    this.episodes,
    this.status,
    this.duration,
    this.rating,
    this.season,
    this.year,
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
  final int? popularityRank;

  Scores({
    this.score,
    this.scoredBy,
    this.rank,
    this.popularityRank,
  });
}

class Trailer {
  final String? youtubeId;
  final String? url;
  final String? embedUrl;

  Trailer({
    required this.youtubeId,
    this.url,
    this.embedUrl,
  });
}

class Broadcast {
  final String? day;
  final String? time;
  final String? timezone;

  Broadcast({
    this.day,
    this.time,
    this.timezone,
  });
}

class Studio {
  final String? name;
  final String? type;
  final String? url;

  Studio({
    this.name,
    this.type,
    this.url,
  });
}

class Producer {
  final String? name;
  final String? type;
  final String? url;

  Producer({
    required this.name,
    required this.type,
    required this.url,
  });
}

class Licensor {
  final String? name;
  final String? type;
  final String? url;

  Licensor({
    required this.name,
    required this.type,
    required this.url,
  });
}

class ExplicitGenre {
  final String? name;
  final String? type;
  final String? url;

  ExplicitGenre({
    required this.name,
    required this.type,
    required this.url,
  });
}

class Theme {
  final String? name;
  final String? type;
  final String? url;

  Theme({
    required this.name,
    required this.type,
    required this.url,
  });
}

class Demographic {
  final String? name;
  final String? type;
  final String? url;

  Demographic({
    required this.name,
    required this.type,
    required this.url,
  });
}

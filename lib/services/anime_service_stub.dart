import 'package:seasonal_anime_app/models/anime.dart';
import 'package:seasonal_anime_app/services/anime_service.dart';

class AnimeServiceStub extends AnimeService {
  @override
  Future<List<Anime>> fetchCurrentSeasonAnime() async {
    await Future.delayed(const Duration(seconds: 1));

    var stubSynopsis =
        "Idly indulging in baseless paranormal activities with the Occult Club, high schooler Yuuji Itadori spends his days at either the clubroom or the hospital, where he visits his bedridden grandfather. However, this leisurely lifestyle soon takes a turn for the strange when he unknowingly encounters a cursed item. Triggering a chain of supernatural occurrences, Yuuji finds himself suddenly thrust into the world of Curses—dreadful beings formed from human malice and negativity—after swallowing the said item, revealed to be a finger belonging to the demon Sukuna Ryoumen, the King of Curses. Yuuji experiences first-hand the threat these Curses pose to society as he discovers his own newfound powers. Introduced to the Tokyo Metropolitan Jujutsu Technical High School, he begins to walk down a path from which he cannot return—the path of a Jujutsu sorcerer.";

    List<Anime> animeList = [
      _createStubAnime(
          1, 'Anime 1', 'assets/images/placeholder.png', stubSynopsis),
      _createStubAnime(
          2, 'Anime 2', 'assets/images/placeholder.png', stubSynopsis),
      _createStubAnime(
          3, 'Anime 3', 'assets/images/placeholder.png', stubSynopsis),
      _createStubAnime(
          4, 'Anime 4', 'assets/images/placeholder.png', stubSynopsis),
      _createStubAnime(
          5, 'Anime 5', 'assets/images/placeholder.png', stubSynopsis),
      _createStubAnime(
          6, 'Anime 6', 'assets/images/placeholder.png', stubSynopsis),
      _createStubAnime(
          7, 'Anime 7', 'assets/images/placeholder.png', stubSynopsis),
      _createStubAnime(
          8, 'Anime 8', 'assets/images/placeholder.png', stubSynopsis),
      _createStubAnime(
          9, 'Anime 9', '/assets/images/placeholder.png', stubSynopsis),
      _createStubAnime(10, 'Anime 10', './assets/images/placeholder.png',
          'Stub synopsis 10'),
    ];

    return animeList;
  }

  Anime _createStubAnime(
      int id, String title, String imageUrl, String synopsis) {
    return Anime(
      malId: id,
      title: title,
      titleEnglish: '$title English',
      titleJapanese: '$title Japanese',
      titleSynonyms: ['$title Synonym 1', '$title Synonym 2'],
      genres: ['Genre 1', 'Genre 2', 'Genre 3'],
      imageUrl: imageUrl,
      synopsis: synopsis,
      type: 'TV',
      episodes: 12,
      status: 'Airing',
      airingStart: '2023-04-01',
      airingEnd: '2023-06-01',
      duration: '24 min',
      rating: 'PG-13',
      score: 8.5,
      scoredBy: 25000,
      rank: id * 100,
      popularity: id * 50,
      members: id * 20000,
      favorites: id * 1000,
    );
  }
}

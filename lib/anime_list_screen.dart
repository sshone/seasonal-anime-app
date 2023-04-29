import 'package:flutter/material.dart';
import 'package:seasonal_anime_app/models/anime.dart';
import 'package:seasonal_anime_app/anime_details_screen.dart';
import 'package:seasonal_anime_app/services/anime_service_stub.dart';

const double paddingSize = 8.0;
const double titleFontSize = 18.0;
const double subtitleFontSize = 14.0;
const double iconSize = 16.0;
const double smallSpacing = 4.0;
const double mediumSpacing = 8.0;
const double cardAspectRatio = 2 / 3;

class AnimeListScreen extends StatelessWidget {
  final AnimeServiceStub _animeService = AnimeServiceStub();

  AnimeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final bool showAppBar = !isLandscape;

    return Scaffold(
      appBar:
          showAppBar ? AppBar(title: const Text('Current Anime Season')) : null,
      body: FutureBuilder<List<Anime>>(
        future: _animeService.fetchCurrentSeasonAnime(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Anime> animeList = snapshot.data!;
            return _buildAnimeList(context, animeList, isLandscape);
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  /// Builds the anime list with cards for each anime.
  Widget _buildAnimeList(
      BuildContext context, List<Anime> animeList, bool isLandscape) {
    return Padding(
      padding: const EdgeInsets.all(paddingSize),
      child: GridView.count(
        crossAxisCount: isLandscape ? 4 : 2,
        childAspectRatio: cardAspectRatio,
        children:
            animeList.map((anime) => _buildAnimeCard(context, anime)).toList(),
      ),
    );
  }

  /// Builds a card for an anime with its image, title, score, and popularity.
  Widget _buildAnimeCard(BuildContext context, Anime anime) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimeDetailsScreen(anime: anime),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: cardAspectRatio,
        child: Card(
          child: Stack(
            children: [
              _buildAnimeImage(anime.imageUrl),
              _buildAnimeDetails(context, anime),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the details overlay for an anime card, including the title, score, and popularity.
  Widget _buildAnimeDetails(BuildContext context, Anime anime) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.all(paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                anime.titleEnglish,
                style: const TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: smallSpacing),
              Row(
                children: [
                  _buildAnimeScore(anime),
                  const SizedBox(width: mediumSpacing),
                  _buildAnimePop(anime),
                ],
              ),
              const SizedBox(height: mediumSpacing),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a row displaying the anime's popularity using a thumb-up icon and the popularity value.
  Widget _buildAnimePop(Anime anime) {
    return Row(
      children: [
        const Icon(Icons.thumb_up, color: Colors.white, size: iconSize),
        const SizedBox(width: smallSpacing),
        Text(
          anime.popularity.toString(),
          style: const TextStyle(
            fontSize: subtitleFontSize,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  /// Builds a row displaying the anime's score using a star icon and the score value.
  Widget _buildAnimeScore(Anime anime) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.yellow, size: iconSize),
        const SizedBox(width: smallSpacing),
        Text(
          anime.score.toString(),
          style: const TextStyle(
            fontSize: subtitleFontSize,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  /// Builds the anime's image with a placeholder in case of errors.
  Widget _buildAnimeImage(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image.asset(
          'assets/images/placeholderAnime.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      },
    );
  }
}

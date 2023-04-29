import 'package:flutter/material.dart';
import 'package:seasonal_anime_app/models/anime.dart';
import 'package:seasonal_anime_app/anime_details_screen.dart';
import 'package:seasonal_anime_app/services/anime_service_stub.dart';

class AnimeListScreen extends StatelessWidget {
  final AnimeServiceStub _animeService = AnimeServiceStub();

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

  Widget _buildAnimeList(
      BuildContext context, List<Anime> animeList, bool isLandscape) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: isLandscape ? 4 : 2,
        childAspectRatio: 2 / 3,
        children:
            animeList.map((anime) => _buildAnimeCard(context, anime)).toList(),
      ),
    );
  }

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
        aspectRatio: 2 / 3,
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

  Widget _buildAnimeDetails(BuildContext context, Anime anime) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                anime.titleEnglish,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  _buildAnimeScore(anime),
                  const SizedBox(width: 8.0),
                  _buildAnimePop(anime),
                ],
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimePop(Anime anime) {
    return Row(
      children: [
        const Icon(Icons.thumb_up, color: Colors.white, size: 16.0),
        const SizedBox(width: 4.0),
        Text(
          anime.popularity.toString(),
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildAnimeScore(Anime anime) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.yellow, size: 16.0),
        const SizedBox(width: 4.0),
        Text(
          anime.score.toString(),
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

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

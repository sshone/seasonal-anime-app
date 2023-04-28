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
            return _buildAnimeList(context, animeList);
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Widget _buildAnimeList(BuildContext context, List<Anime> animeList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: animeList.length,
        itemBuilder: (context, index) {
          Anime anime = animeList[index];
          return _buildAnimeCard(context, anime);
        },
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
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _buildAnimeImage(anime.imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                anime.titleEnglish,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimeImage(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/images/placeholderAnime.jpg', // Path to your fallback image asset
          fit: BoxFit.cover,
        );
      },
    );
  }
}

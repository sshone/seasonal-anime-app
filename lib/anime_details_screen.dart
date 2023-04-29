import 'package:flutter/material.dart';
import 'package:seasonal_anime_app/models/anime.dart';

class AnimeDetailsScreen extends StatelessWidget {
  final Anime anime;

  const AnimeDetailsScreen({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final bool showAppBar = !isLandscape;

    return Scaffold(
      appBar: showAppBar ? AppBar(title: const Text('Anime Details')) : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildImage(),
                Positioned(
                  bottom: 16.0,
                  left: 16.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          anime.titleEnglish,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            _buildScore('Score:', anime.score.toString()),
                            const SizedBox(width: 12.0),
                            _buildScore('Rank:', anime.rank.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText('Japanese Title:', anime.titleJapanese),
                  const SizedBox(height: 8),
                  _buildText(
                    'Alternative Titles:',
                    anime.titleSynonyms.join(', '),
                  ),
                  const SizedBox(height: 16),
                  _buildText('Synopsis:', anime.synopsis),
                  const SizedBox(height: 16),
                  _buildInfoGrid([
                    _buildText('Type', anime.type),
                    _buildText('Episodes', anime.episodes.toString()),
                    _buildText('Status', anime.status),
                    _buildText('Duration', anime.duration),
                    _buildText('Rating', anime.rating),
                  ]),
                  const SizedBox(height: 16),
                  _buildAiringDates(),
                  const SizedBox(height: 16),
                  _buildScores(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Image.network(
      anime.imageUrl,
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

  Widget _buildText(String label, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildInfoGrid(List<Widget> children) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: children,
    );
  }

  Widget _buildAiringDates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Airing Dates:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        _buildInfoGrid([
          _buildText('From', anime.airingStart),
          _buildText('To', anime.airingEnd),
        ]),
      ],
    );
  }

  Widget _buildScores() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Scores:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildInfoGrid(
          [
            _buildScore('Popularity', anime.popularity.toString()),
          ],
        ),
      ],
    );
  }

  Widget _buildScore(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      ],
    );
  }
}

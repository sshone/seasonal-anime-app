import 'package:flutter/material.dart';
import 'package:seasonal_anime_app/models/anime.dart';

class AnimeDetailsScreen extends StatelessWidget {
  final Anime anime;
  static const double defaultSpacing = 8.0;
  static const double titleFontSize = 16.0;
  static const double contentFontSize = 14.0;

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
                            _buildAnimeScore(anime),
                            const SizedBox(width: 12.0),
                            _buildAnimePop(anime),
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

  /// Builds a text widget for a label and value pair.
  Widget _buildText(String label, String? text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: titleFontSize, fontWeight: FontWeight.bold),
        ),
        Text(
          text ?? '',
          style:
              const TextStyle(fontSize: contentFontSize, color: Colors.black),
        ),
      ],
    );
  }

  /// Builds a grid of information widgets.
  Widget _buildInfoGrid(List<Widget> children) {
    return Wrap(
      spacing: defaultSpacing,
      runSpacing: defaultSpacing,
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
            _buildText('Score', anime.score.toString()),
            _buildText('Rank', anime.rank.toString()),
            _buildText('Popularity', anime.popularity.toString()),
          ],
        ),
      ],
    );
  }

  /// Builds a row displaying the anime's popularity using a thumb-up icon and the popularity value.
  Widget _buildAnimePop(Anime anime) {
    return Row(
      children: [
        const Icon(Icons.thumb_up, color: Colors.white, size: 16),
        const SizedBox(width: 4),
        Text(
          anime.popularity.toString(),
          style: const TextStyle(
            fontSize: contentFontSize,
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
        const Icon(Icons.star, color: Colors.yellow, size: 16),
        const SizedBox(width: 4),
        Text(
          anime.score.toString(),
          style: const TextStyle(
            fontSize: contentFontSize,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:seasonal_anime_app/models/anime.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
      appBar: showAppBar
          ? AppBar(title: Text(anime.titleDetails?.titleEnglish ?? anime.title))
          : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildImage(),
                _buildOverlay(),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText(
                      'Japanese Title:', anime.titleDetails?.titleJapanese),
                  const SizedBox(height: 8),
                  _buildText(
                    'Alternative Titles:',
                    anime.titleSynonyms?.join(', '),
                  ),
                  const SizedBox(height: 16),
                  _buildText('Synopsis:', anime.synopsis),
                  const SizedBox(height: 16),
                  _buildInfoGrid([
                    _buildText('Type', anime.details?.type),
                    _buildText('Episodes', anime.details?.episodes.toString()),
                    _buildText('Status', anime.details?.status),
                    _buildText('Duration', anime.details?.duration),
                    _buildText('Rating', anime.details?.rating),
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

  Widget _buildOverlay() {
    return Positioned(
      bottom: 16.0,
      left: 16.0,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final availableWidth = constraints.maxWidth;

          return Container(
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
                _buildAutoSizeText(
                  anime.titleDetails?.titleEnglish ?? anime.title,
                  availableWidth,
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
          );
        },
      ),
    );
  }

  Widget _buildAutoSizeText(String text, double availableWidth) {
    return AutoSizeText(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      maxLines: 2,
      minFontSize: 12, // Adjust the minimum font size as needed
      maxFontSize: 20, // Adjust the maximum font size as needed
      overflowReplacement: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:
              12, // Adjust the font size for overflow replacement as needed
          color: Colors.white,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
      imageUrl: anime.imageUrls.largeImageUrl ?? anime.imageUrls.imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorWidget: (context, url, error) => Image.asset(
        'assets/images/placeholderAnime.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  /// Builds a text widget for a label and value pair.
  Widget _buildText(String label, String? text) {
    if (text == null || text.isEmpty) {
      return const SizedBox.shrink(); // Return an empty widget if text is null
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: titleFontSize, fontWeight: FontWeight.bold),
        ),
        Text(
          text,
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
          _buildText('From', anime.airingSchedule?.airingStart ?? ''),
          if (anime.airingSchedule?.airingEnd != null)
            _buildText('To', anime.airingSchedule?.airingEnd),
        ]),
      ],
    );
  }

  Widget _buildScores() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoGrid(
          [
            _buildText('Score', anime.scores?.score.toString()),
            _buildText('Rank', anime.scores?.rank.toString()),
            _buildText('Popularity', anime.scores?.popularity.toString()),
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
          anime.scores?.popularity.toString() ?? '',
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
          anime.scores?.score.toString() ?? '',
          style: const TextStyle(
            fontSize: contentFontSize,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:seasonal_anime_app/models/anime.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AnimeDetailsScreen extends StatelessWidget {
  final Anime anime;
  static const double defaultVerticalSpacing = 16.0;
  static const double defaultHorizontalSpacing = 8.0;
  static const double titleFontSize = 16.0;
  static const double contentFontSize = 14.0;

  const AnimeDetailsScreen({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _buildPortraitLayout(context);
          } else {
            return _buildLandscapeLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(context, Orientation.portrait),
        _buildSliverList(context),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = screenWidth * 1 / 3;
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      children: [
        SizedBox(
          width: imageWidth,
          height: screenHeight,
          child: _buildImage(),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              _buildSliverAppBar(context, Orientation.landscape),
              _buildSliverList(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar(BuildContext context, Orientation orientation) {
    final screenHeight = MediaQuery.of(context).size.height;

    if (orientation == Orientation.landscape) {
      return SliverAppBar(
        pinned: true,
        title: AutoSizeText(
          anime.titleDetails?.titleEnglish ?? anime.title,
          style: const TextStyle(
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 2.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
          maxLines: 2,
        ),
      );
    }

    return SliverAppBar(
      expandedHeight: screenHeight * 2 / 3,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: AutoSizeText(
          anime.titleDetails?.titleEnglish ?? anime.title,
          style: const TextStyle(
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 2.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
          maxLines: 2,
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            _buildImage(),
            _buildGradientOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverList(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            color: Theme.of(context).canvasColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Synopsis'),
                _buildText(null, anime.synopsis),
                _buildSectionHeader('Title Information'),
                _buildText(
                    'Japanese Title:', anime.titleDetails?.titleJapanese),
                _buildText(
                  'Alternative Titles:',
                  anime.titleSynonyms?.join(', '),
                ),
                _buildSectionHeader('Anime Details'),
                _buildInfoGrid([
                  _buildText('Type', anime.details?.type),
                  _buildText('Episodes', anime.details?.episodes.toString()),
                  _buildText('Status', anime.details?.status),
                  _buildText('Duration', anime.details?.duration),
                  _buildText('Rating', anime.details?.rating),
                ]),
                _buildSectionHeader('Airing Dates'),
                _buildAiringDates(),
                _buildSectionHeader('Scores & Rankings'),
                _buildScores(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildGradientOverlay() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.2),
            Colors.transparent
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const [0, 0.5, 1],
        ),
      ),
    );
  }

  Widget _buildScoreAndPopularity() {
    return Positioned(
      bottom: 16.0, // Move it closer to the bottom edge
      left: 16.0,
      child: Row(
        // Change to Row for horizontal layout
        children: [
          _buildAnimeScore(anime),
          const SizedBox(
              width: 16.0), // Add horizontal space between score and popularity
          _buildAnimePop(anime),
        ],
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20, // Increase the font size for section headers
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Builds a text widget for a label and value pair.
  Widget _buildText(String? label, String? text) {
    if (text == null || text.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label,
            style: const TextStyle(
                fontSize: titleFontSize, fontWeight: FontWeight.bold),
          ),
        Text(
          text,
          style: const TextStyle(fontSize: contentFontSize),
        ),
        const SizedBox(height: defaultVerticalSpacing),
      ],
    );
  }

  /// Builds a grid of information widgets.
  Widget _buildInfoGrid(List<Widget> children) {
    return Wrap(
      spacing: defaultVerticalSpacing,
      runSpacing: defaultHorizontalSpacing,
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

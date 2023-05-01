import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seasonal_anime_app/services/anime_service.dart';

import '../models/anime.dart';
import 'anime_details_screen.dart';

enum SortOption { title, score, popularity }

enum SortOrder { ascending, descending }

const double paddingSize = 8.0;
const double titleFontSize = 18.0;
const double subtitleFontSize = 14.0;
const double iconSize = 16.0;
const double smallSpacing = 4.0;
const double mediumSpacing = 8.0;
const double cardAspectRatio = 2 / 3;

class AnimeListScreen extends StatefulWidget {
  AnimeListScreen({Key? key}) : super(key: key);

  @override
  _AnimeListScreenState createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> {
  final AnimeServiceApi _animeService = AnimeServiceApi();
  SortOption _sortOption = SortOption.score;
  SortOrder _sortOrder = SortOrder.descending;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final bool showAppBar = !isLandscape;

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: const Text('Current Anime Season'),
              actions: [
                PopupMenuButton<dynamic>(
                  icon: const Icon(Icons.sort),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: SortOption.title,
                      child: Text("Sort by Title"),
                    ),
                    const PopupMenuItem(
                      value: SortOption.score,
                      child: Text("Sort by Score"),
                    ),
                    const PopupMenuItem(
                      value: SortOption.popularity,
                      child: Text("Sort by Popularity"),
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem(
                      value: SortOrder.ascending,
                      child: Text("Ascending"),
                    ),
                    const PopupMenuItem(
                      value: SortOrder.descending,
                      child: Text("Descending"),
                    ),
                  ],
                  onSelected: (dynamic value) {
                    setState(() {
                      if (value is SortOption) {
                        _sortOption = value;
                      } else if (value is SortOrder) {
                        _sortOrder = value;
                      }
                    });
                  },
                ),
              ],
            )
          : null,
      body: FutureBuilder<List<Anime>>(
        future: _animeService.fetchCurrentSeasonAnime().catchError((error) {
          if (kDebugMode) {
            print('Failed to load seasonal anime: $error');
          }
          return Future.value(<Anime>[]); // Return an empty list of anime
        }),
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
    animeList.sort((a, b) {
      int compareResult;
      switch (_sortOption) {
        case SortOption.title:
          compareResult = a.title.compareTo(b.title);
          break;
        case SortOption.score:
          compareResult =
              (a.scores?.score ?? 0).compareTo(b.scores?.score ?? 0);
          break;
        case SortOption.popularity:
          compareResult =
              (a.scores?.popularity ?? 0).compareTo(b.scores?.popularity ?? 0);
          break;
      }
      return _sortOrder == SortOrder.ascending ? compareResult : -compareResult;
    });

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
              _buildAnimeImage(anime.imageUrls.imageUrl),
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
          padding: const EdgeInsets.all(paddingSize),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.titleDetails?.titleEnglish ?? anime.title,
                    style: TextStyle(
                      fontSize: _calculateTitleFontSize(availableWidth,
                          anime.titleDetails?.titleEnglish ?? anime.title),
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
              );
            },
          ),
        ),
      ),
    );
  }

  double _calculateTitleFontSize(double availableWidth, String title) {
    const baseFontSize = titleFontSize;
    const minFontSize = 14.0;

    final textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: const TextStyle(fontSize: baseFontSize),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    double fontSize = baseFontSize;
    if (textPainter.size.width > availableWidth) {
      fontSize = availableWidth / textPainter.size.width * baseFontSize;
      fontSize = fontSize.clamp(minFontSize, baseFontSize);
    }

    return fontSize;
  }

  /// Builds a row displaying the anime's popularity using a thumb-up icon and the popularity value.
  Widget _buildAnimePop(Anime anime) {
    return Row(
      children: [
        const Icon(Icons.thumb_up, color: Colors.white, size: iconSize),
        const SizedBox(width: smallSpacing),
        Text(
          anime.scores?.popularity.toString() ?? 'N/A',
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
          anime.scores?.score.toString() ?? 'N/A',
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
    return CachedNetworkImage(
      imageUrl: imageUrl,
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
}

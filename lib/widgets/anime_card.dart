import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:seasonal_anime_app/models/anime.dart';

import 'anime_image.dart';

const double paddingSize = 8.0;
const double defaultTitleFontSize = 16.0;
const double subtitleFontSize = 10.0;
const double iconSize = 16.0;
const double smallSpacing = 4.0;
const double mediumSpacing = 8.0;
const double cardAspectRatio = 2 / 3;

class AnimeCard extends StatelessWidget {
  final Anime anime;
  final VoidCallback onTap;

  const AnimeCard({
    Key? key,
    required this.anime,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: cardAspectRatio,
        child: Card(
          child: Stack(
            children: [
              AnimeImage(imageUrl: anime.imageUrls.imageUrl),
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    anime.titleDetails?.titleEnglish ?? anime.title,
                    style: const TextStyle(
                      fontSize: defaultTitleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    maxFontSize: defaultTitleFontSize,
                    minFontSize: 8.0,
                  ),
                  const SizedBox(height: smallSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAnimeInfo(Icons.star,
                          anime.scores?.score?.toString(), Colors.yellow),
                      const SizedBox(width: mediumSpacing),
                      _buildAnimeInfo(
                          Icons.emoji_events,
                          anime.scores?.rank != null
                              ? '#${anime.scores?.rank}'
                              : null,
                          Colors.grey),
                      const SizedBox(width: mediumSpacing),
                      _buildAnimeInfo(Icons.thumb_up,
                          anime.favorites?.toString(), Colors.blueGrey),
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

  Widget _buildAnimeInfo(IconData iconData, String? text, Color iconColor) {
    if (text == null || text.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        Icon(iconData, color: iconColor, size: iconSize),
        const SizedBox(width: smallSpacing),
        Text(
          text,
          style: const TextStyle(
            fontSize: subtitleFontSize,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

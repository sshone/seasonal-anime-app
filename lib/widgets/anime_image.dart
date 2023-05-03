import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimeImage extends StatelessWidget {
  final String imageUrl;

  const AnimeImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorWidget: (context, url, error) => Image.asset(
        'assets/images/placeholderAnime.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

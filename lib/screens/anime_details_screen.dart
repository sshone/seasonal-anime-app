import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/anime.dart';
import 'fullscreen_image.dart';

class AnimeDetailsScreen extends StatelessWidget {
  final Anime anime;

  const AnimeDetailsScreen({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: isLandscape
          ? null
          : AppBar(
              title: Text(anime.titleDetails?.titleEnglish ?? anime.title)),
      body: isLandscape
          ? _buildLandscapeLayout(context)
          : _buildPortraitLayout(context),
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCoverImage(context, isLandscape: true),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                title: Text(anime.titleDetails?.titleEnglish ?? anime.title),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _buildGenresWidget(),
                    _buildSynopsisAndAdditionalInfo(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                child: _buildCoverImage(context, isLandscape: false),
              ),
              Expanded(child: _buildInfoSection()),
            ],
          ),
          _buildGenresWidget(),
          _buildSynopsisAndAdditionalInfo(context),
        ],
      ),
    );
  }

  Widget _buildSynopsisAndAdditionalInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Synopsis',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(anime.synopsis ?? ''),
          const SizedBox(height: 16),
          const Text(
            'Additional Information',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // Add additional information widgets here
        ],
      ),
    );
  }

  Widget _buildIconText(IconData icon, String? text) {
    if (text == null || text.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText(),
          const SizedBox(height: 4),
          _buildIconText(Icons.movie, anime.details?.type),
          _buildIconText(Icons.format_list_numbered,
              '${anime.details?.episodes} episodes'),
          _buildIconText(Icons.live_tv, anime.details?.status),
          _buildIconText(Icons.star, '${anime.scores?.score}'),
          _buildIconText(Icons.thumb_up, anime.scores?.popularity.toString()),
        ],
      ),
    );
  }

  Widget _buildGenresWidget() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: anime.genres?.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                anime.genres![index].name,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoverImage(BuildContext context, {required bool isLandscape}) {
    final imageHeight =
        isLandscape ? MediaQuery.of(context).size.height : 200.0;
    final imageWidth =
        isLandscape ? MediaQuery.of(context).size.width / 3 : 150.0;

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullscreenImage(
            imageUrl: anime.imageUrls.largeImageUrl ?? anime.imageUrls.imageUrl,
          ),
        ),
      ),
      child: SizedBox(
        height: imageHeight,
        width: imageWidth,
        child: CachedNetworkImage(
          imageUrl: anime.imageUrls.imageUrl,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/placeholderAnime.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText() {
    return AutoSizeText(
      anime.titleDetails?.titleEnglish ?? anime.title,
      style: const TextStyle(
        fontSize: 20,
        shadows: [
          Shadow(
            offset: Offset(1.0, 1.0),
            blurRadius: 2.0,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
      maxLines: 3,
    );
  }
}

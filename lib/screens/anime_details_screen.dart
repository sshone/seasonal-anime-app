import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/anime.dart';
import 'fullscreen_image.dart';

class AnimeDetailsScreen extends StatefulWidget {
  final Anime anime;

  const AnimeDetailsScreen({Key? key, required this.anime}) : super(key: key);

  @override
  AnimeDetailsScreenState createState() => AnimeDetailsScreenState();
}

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: [
        Tab(text: 'Details'),
        Tab(text: 'Stats'),
        Tab(text: 'Media'),
        Tab(text: 'More Info'),
      ],
    );
  }
}

class AnimeDetailsScreenState extends State<AnimeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: isLandscape
            ? null
            : AppBar(
                title: Text(widget.anime.titleDetails?.titleEnglish ??
                    widget.anime.title)),
        body: isLandscape
            ? _buildLandscapeLayout(context)
            : _buildPortraitLayout(context),
      ),
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
                title: Text(widget.anime.titleDetails?.titleEnglish ??
                    widget.anime.title),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGenresWidget(),
                      const CustomTabBar(),
                    ],
                  ),
                ]),
              ),
              SliverFillRemaining(child: _buildTabBarView(context)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return Column(
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGenresWidget(),
              const CustomTabBar(),
            ],
          ),
        ),
        Expanded(child: _buildTabBarView(context)),
      ],
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    return TabBarView(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Synopsis',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(widget.anime.synopsis ?? ''),
                const SizedBox(height: 16),
                _buildAdditionalInfo(context),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Stats',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildStats(context),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Media',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildMedia(context),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'More Info',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildMoreInfo(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return GridView.count(
      crossAxisCount: isLandscape ? 2 : 2,
      childAspectRatio: isLandscape ? 2 : 1.5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard(
          context,
          Icons.favorite,
          'Favorites',
          widget.anime.favorites?.toString(),
        ),
        _buildStatCard(
          context,
          Icons.thumb_up,
          'Popularity Rank',
          widget.anime.scores?.popularityRank?.toString(),
        ),
        _buildStatCard(
          context,
          Icons.star,
          'Score',
          widget.anime.scores?.score?.toString(),
        ),
        _buildStatCard(
          context,
          Icons.format_list_numbered,
          'Episodes',
          widget.anime.details?.episodes?.toString(),
        ),
        _buildStatCard(
          context,
          Icons.live_tv,
          'Status',
          widget.anime.details?.status,
        ),
        _buildStatCard(
          context,
          Icons.movie,
          'Type',
          widget.anime.details?.type,
        ),
        _buildStatCard(
          context,
          Icons.access_time,
          'Episode Duration',
          widget.anime.details?.duration,
        ),
      ]
          .where((card) => card != null)
          .map((card) => Flexible(child: FractionallySizedBox(child: card!)))
          .toList(),
    );
  }

  Widget? _buildStatCard(
    BuildContext context,
    IconData icon,
    String label,
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            AutoSizeText(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            AutoSizeText(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedia(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMediaItem(context, Icons.image, 'Cover Image',
            widget.anime.imageUrls.imageUrl),
        _buildMediaItem(context, Icons.video_library, 'Trailer',
            widget.anime.trailer?.youtubeId),
      ],
    );
  }

  Widget _buildMediaItem(
    BuildContext context,
    IconData icon,
    String label,
    String? url,
  ) {
    if (url == null || url.isEmpty) {
      return const SizedBox.shrink();
    }

    String? videoId;
    if (label == 'Trailer') {
      videoId = YoutubePlayer.convertUrlToId(url);
    }

    String? thumbnailUrl;
    if (videoId != null) {
      thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
    }

    return GestureDetector(
      onTap: () {
        if (label == 'Cover Image') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullscreenImage(imageUrl: url),
            ),
          );
        } else if (label == 'Trailer') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                body: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: videoId!,
                            flags: const YoutubePlayerFlags(autoPlay: true),
                          ),
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.blueAccent,
                          progressColors: const ProgressBarColors(
                            playedColor: Colors.blueAccent,
                            handleColor: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Text(label),
              ],
            ),
            if (label == 'Trailer' && thumbnailUrl != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: thumbnailUrl,
                      fit: BoxFit.cover,
                    ),
                    const Icon(
                      Icons.play_circle_fill,
                      size: 64,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleInfo(
            'Title (English)', widget.anime.titleDetails?.titleEnglish),
        _buildTitleInfo(
            'Title (Japanese)', widget.anime.titleDetails?.titleJapanese),
        _buildSectionInfo('Type', widget.anime.details?.type),
        _buildSectionInfo('Rating', widget.anime.details?.rating),
        _buildSectionInfo('Season', widget.anime.details?.season),
        _buildSectionInfo('Year', widget.anime.details?.year?.toString()),
        _buildSectionInfo('Broadcast', _buildBroadcastText()),
        _buildSectionInfo('Background', widget.anime.background),
        _buildSectionInfo('Producers', _buildProducerText()),
        _buildSectionInfo('Licensors', _buildLicensorsText()),
        _buildSectionInfo('Studios', _buildStudiosText()),
        _buildSectionInfo('Explicit Genres', _buildExplicitGenresText()),
        _buildSectionInfo('Themes', _buildThemesText()),
        _buildSectionInfo('Demographics', _buildDemographicsText()),
      ],
    );
  }

  Widget _buildTitleInfo(String label, String? value) {
    if (value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildSectionInfo(String label, String? value) {
    if (value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  String _buildBroadcastText() {
    final broadcast = widget.anime.broadcast;
    if (broadcast != null) {
      final day = broadcast.day ?? '';
      final time = broadcast.time ?? '';
      final timezone = broadcast.timezone ?? '';
      return '$day, $time $timezone';
    }
    return 'N/A';
  }

  String _buildProducerText() {
    final producers = widget.anime.producers;
    if (producers != null) {
      return producers.map((producer) => producer.name).join(', ');
    }
    return 'N/A';
  }

  String _buildLicensorsText() {
    final licensors = widget.anime.licensors;
    if (licensors != null) {
      return licensors.map((licensor) => licensor.name).join(', ');
    }
    return 'N/A';
  }

  String _buildStudiosText() {
    final studios = widget.anime.studios;
    if (studios != null) {
      return studios.map((studio) => studio.name).join(', ');
    }
    return 'N/A';
  }

  String _buildExplicitGenresText() {
    final explicitGenres = widget.anime.explicitGenres;
    if (explicitGenres != null) {
      return explicitGenres.map((genre) => genre.name).join(', ');
    }
    return 'N/A';
  }

  String _buildThemesText() {
    final themes = widget.anime.themes;
    if (themes != null) {
      return themes.map((theme) => theme.name).join(', ');
    }
    return 'N/A';
  }

  String _buildDemographicsText() {
    final demographics = widget.anime.demographics;
    if (demographics != null) {
      return demographics.map((demo) => demo.name).join(', ');
    }
    return 'N/A';
  }

  Widget _buildAdditionalInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(widget.anime.titleDetails?.titleEnglish ?? ''),
        const SizedBox(height: 8),
        Text(widget.anime.titleDetails?.titleJapanese ?? ''),
      ],
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
          _buildIconText(Icons.movie, widget.anime.details?.type),
          if (widget.anime.details?.episodes != null)
            _buildIconText(Icons.format_list_numbered,
                '${widget.anime.details!.episodes} episodes'),
          _buildIconText(Icons.live_tv, widget.anime.details?.status),
          _buildIconText(Icons.star, '${widget.anime.scores?.score}'),
          _buildIconText(
              Icons.thumb_up, widget.anime.scores?.popularityRank.toString()),
        ],
      ),
    );
  }

  Widget _buildGenresWidget() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: widget.anime.genres?.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                widget.anime.genres![index].name,
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
            imageUrl: widget.anime.imageUrls.largeImageUrl ??
                widget.anime.imageUrls.imageUrl,
          ),
        ),
      ),
      child: SizedBox(
        height: imageHeight,
        width: imageWidth,
        child: CachedNetworkImage(
          imageUrl: widget.anime.imageUrls.imageUrl,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/placeholderAnime.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText() {
    return AutoSizeText(
      widget.anime.titleDetails?.titleEnglish ?? widget.anime.title,
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

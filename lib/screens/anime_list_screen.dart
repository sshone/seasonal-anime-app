import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seasonal_anime_app/services/anime_service.dart';

import '../models/anime.dart';
import '../widgets/anime_card.dart';
import 'anime_details_screen.dart';

enum SortOption { title, score, rank, favorites }

enum SortOrder { ascending, descending }

const double paddingSize = 8.0;
const double titleFontSize = 18.0;
const double subtitleFontSize = 10.0;
const double iconSize = 16.0;
const double smallSpacing = 4.0;
const double mediumSpacing = 8.0;
const double cardAspectRatio = 2 / 3;

class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({Key? key}) : super(key: key);

  @override
  AnimeListScreenState createState() => AnimeListScreenState();
}

class AnimeListScreenState extends State<AnimeListScreen> {
  final AnimeServiceApi _animeService = AnimeServiceApi();
  SortOption _sortOption = SortOption.score;
  SortOrder _sortOrder = SortOrder.descending;
  bool _showSortOptions = false;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final bool showAppBar = !isLandscape;

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: const Text('Anime Season Guide'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: () {
                    setState(() {
                      _showSortOptions = !_showSortOptions;
                    });
                  },
                ),
              ],
            )
          : null,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<Anime>>(
                        future: _animeService
                            .fetchCurrentSeasonAnime()
                            .catchError((error) {
                          if (kDebugMode) {
                            print('Failed to load seasonal anime: $error');
                          }
                          return Future.value(
                              <Anime>[]); // Return an empty list of anime
                        }),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            List<Anime> animeList = snapshot.data!;
                            return _buildAnimeList(
                                context, animeList, isLandscape);
                          } else {
                            return const Center(
                                child: Text('No data available'));
                          }
                        },
                      ),
                    ),
                  ],
                ),
                _buildSortOptionsBanner(),
              ],
            ),
          ),
        ],
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
        case SortOption.rank:
          compareResult =
              (b.scores?.rank ?? 9999).compareTo(a.scores?.rank ?? 9999);
          break;
        case SortOption.favorites:
          compareResult = (a.favorites ?? 9999).compareTo(b.favorites ?? 9999);
          break;
      }
      return _sortOrder == SortOrder.ascending ? compareResult : -compareResult;
    });

    return Padding(
      padding: const EdgeInsets.all(paddingSize),
      child: GridView.count(
        crossAxisCount: isLandscape ? 4 : 2,
        childAspectRatio: cardAspectRatio,
        children: animeList
            .map((anime) => AnimeCard(
                anime: anime,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimeDetailsScreen(anime: anime),
                    ),
                  );
                }))
            .toList(),
      ),
    );
  }

  Widget _buildSortOptionsBanner() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: _showSortOptions ? 0 : -kToolbarHeight,
      left: 0,
      right: 0,
      child: Material(
        elevation: 4.0,
        child: Container(
          height: kToolbarHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.sort),
              DropdownButton<SortOption>(
                value: _sortOption,
                onChanged: (SortOption? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _sortOption = newValue;
                    });
                  }
                },
                items: SortOption.values
                    .map<DropdownMenuItem<SortOption>>((SortOption value) {
                  return DropdownMenuItem<SortOption>(
                    value: value,
                    child: Text(value.toString().split('.').last),
                  );
                }).toList(),
              ),
              DropdownButton<SortOrder>(
                value: _sortOrder,
                onChanged: (SortOrder? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _sortOrder = newValue;
                    });
                  }
                },
                items: SortOrder.values
                    .map<DropdownMenuItem<SortOrder>>((SortOrder value) {
                  return DropdownMenuItem<SortOrder>(
                    value: value,
                    child: Text(value.toString().split('.').last),
                  );
                }).toList(),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _showSortOptions = false;
                  });
                },
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:seasonal_anime_app/models/anime.dart';

import 'cache_service.dart';

abstract class AnimeService {
  Future<List<Anime>> fetchCurrentSeasonAnime();
}

class AnimeServiceApi implements AnimeService {
  final String _baseUrl = 'https://api.jikan.moe/v4/seasons/now';
  final CacheService _cacheService = CacheService(1);
  final int maxRetries = 3;
  final int retryDelayMilliseconds = 1000;
  final int maxRequestsPerSecond = 1;
  final int maxConsecutiveErrors = 3;
  int currentRequests = 0;
  DateTime? lastRequestTime;

  @override
  Future<List<Anime>> fetchCurrentSeasonAnime() async {
    log('Fetching current season anime');
    final cachedData =
        _cacheService.getData<List<Anime>>('current_season_anime');
    if (cachedData != null) {
      log('Returning cached data');
      return cachedData;
    } else {
      log('Fetching data from API');
      final List<Anime> animeList = await _fetchAnimeListWithRetries();
      _cacheService.setData('current_season_anime', animeList);
      return animeList;
    }
  }

  Future<List<Anime>> _fetchAnimeListWithRetries() async {
    int retryCount = 0;
    int consecutiveErrors = 0;
    List<Anime> animeList = [];
    int currentPage = 1;

    do {
      log('Attempting to fetch page $currentPage');
      if (_canMakeRequest()) {
        final response = await _fetchPageData(currentPage);
        if (_isSuccessfulResponse(response)) {
          final jsonResponse = jsonDecode(response.body);
          final fetchedAnimeList = _parseAnimeList(jsonResponse);
          animeList.addAll(fetchedAnimeList);
          if (!_hasNextPage(jsonResponse)) {
            break;
          }
          retryCount = 0;
          consecutiveErrors = 0;
          _updateRequestTime();
          log('Page $currentPage loaded successfully.');
          currentPage++;
        } else {
          retryCount++;
          consecutiveErrors++;
          log('Failed to load page $currentPage. Retrying...');
          await _delayRetry();
        }
      } else {
        log('API rate limit reached. Waiting for cooldown...');
        await _delayCooldown();
      }

      if (consecutiveErrors >= maxConsecutiveErrors) {
        throw Exception(
            'Too many consecutive errors. Failed to load seasonal anime.');
      }
    } while (
        retryCount < maxRetries && consecutiveErrors < maxConsecutiveErrors);

    return animeList;
  }

  Future<http.Response> _fetchPageData(int page) async {
    final response = await http.get(Uri.parse('$_baseUrl?page=$page'));
    log('Response status code: ${response.statusCode}');
    return response;
  }

  bool _isSuccessfulResponse(http.Response response) {
    return response.statusCode == 200;
  }

  List<Anime> _parseAnimeList(Map<String, dynamic> jsonResponse) {
    final List<dynamic> data = jsonResponse['data'];
    log('Fetched ${data.length} anime');
    log('Attempting to parse anime');
    return data.map((jsonAnime) => Anime.fromJson(jsonAnime)).toList();
  }

  Future<void> _delayRetry() {
    return Future.delayed(Duration(milliseconds: retryDelayMilliseconds));
  }

  Future<void> _delayCooldown() {
    return Future.delayed(Duration(milliseconds: retryDelayMilliseconds));
  }

  bool _hasNextPage(Map<String, dynamic> jsonResponse) {
    return jsonResponse['pagination']['has_next_page'];
  }

  bool _canMakeRequest() {
    final now = DateTime.now();
    final lastRequest = lastRequestTime;
    if (lastRequest != null && now.difference(lastRequest).inSeconds < 1) {
      if (currentRequests >= maxRequestsPerSecond) {
        return false;
      }
    } else {
      currentRequests = 0;
    }
    return true;
  }

  void _updateRequestTime() {
    currentRequests++;
    lastRequestTime = DateTime.now();
  }
}

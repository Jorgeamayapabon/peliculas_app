import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';


class MoviesProvider extends ChangeNotifier {

  final String _apiKey   = '512c0f2d24ccb09a2308a685dc23a938';
  final String _baseUrl  = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;

  MoviesProvider() {

    getOnDisplayMovies();
    getPopularMovie();
  }

  Future<String> _getJsonData( String endPoint, [int page = 1]) async {

    var url = Uri.https( _baseUrl, endPoint, {
      'api_key' : _apiKey,
      'language': _language,
      'page'    : '$page'
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

    return response.body;
  }

  getOnDisplayMovies() async {

    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovie() async {

    _popularPage++;

    final jsonData = await _getJsonData( '3/movie/popular', _popularPage );
    final popularResponse = PopularResponse.fromJson( jsonData );

    popularMovies = [ ...popularMovies, ...popularResponse.results ];

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast( int movieId ) async {

    if( movieCast.containsKey(movieId)) return movieCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson( jsonData );

    movieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
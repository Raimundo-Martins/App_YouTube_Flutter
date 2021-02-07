import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_youtube_api/models/video.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorites = {};

  final _favoriteController =
      BehaviorSubject<Map<String, Video>>(seedValue: {});
  Stream<Map<String, Video>> get outFavorite => _favoriteController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then(
      (prefs) {
        if (prefs.getKeys().contains('favorites')) {
          _favorites =
              json.decode(prefs.getString('favorites')).map((key, valor) {
            return MapEntry(key, Video.fromJson(valor));
          }).cast<String, Video>();
          _favoriteController.add(_favorites);
        }
      },
    );
  }

  void _saveFavorite() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('favorites', json.encode(_favorites));
    });
  }

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id))
      _favorites.remove(video.id);
    else
      _favorites[video.id] = video;

    _favoriteController.sink.add(_favorites);

    _saveFavorite();
  }

  @override
  void dispose() {
    _favoriteController.close();
  }
}

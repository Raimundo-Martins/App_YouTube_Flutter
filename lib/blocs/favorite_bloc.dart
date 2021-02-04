import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_youtube/models/video.dart';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorites = {};

  final _favoriteController = StreamController<Map<String, Video>>.broadcast();
  Stream<Map<String, Video>> get outFavorite => _favoriteController.stream;

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id))
      _favorites.remove(video.id);
    else
      _favorites[video.id] = video;

    _favoriteController.sink.add(_favorites);
  }

  @override
  void dispose() {
    _favoriteController.close();
  }
}

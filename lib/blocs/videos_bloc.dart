import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_youtube_api/api.dart';
import 'package:flutter_youtube_api/models/video.dart';

class VideosBloc implements BlocBase {
  Api api;

  List<Video> listVideos;

  final _streamController = StreamController<List<Video>>();
  Stream get outVideos => _streamController.stream;

  final _searchStreamController = StreamController<String>();
  Sink get inSearch => _searchStreamController.sink;

  VideosBloc() {
    api = Api();
    _searchStreamController.stream.listen(_search);
  }

  void _search(String search) async {
    if (search != null) {
      _streamController.sink.add([]);
      listVideos = await api.search(search);
    } else {
      listVideos += await api.nextPage();
    }
    _streamController.sink.add(listVideos);
  }

  @override
  void dispose() {
    _streamController.close();
    _searchStreamController.close();
  }
}

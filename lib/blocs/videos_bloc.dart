import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_youtube/api.dart';
import 'package:flutter_youtube/models/video.dart';

class VideosBloc implements BlocBase {
  Api api;

  List<Video> listVideos;

  final _streamController = StreamController();
  Stream get outVideos => _streamController.stream;

  final _searchStreamController = StreamController();
  Sink get inSearch => _searchStreamController.sink;

  VideosBloc() {
    api = Api();
    _searchStreamController.stream.listen(_search);
  }

  void _search(String search) async {
    listVideos = await api.search(search);
  }

  @override
  void dispose() {
    _streamController.close();
    _searchStreamController.close();
  }
}
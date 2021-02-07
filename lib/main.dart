import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_api/blocs/favorite_bloc.dart';
import 'package:flutter_youtube_api/blocs/videos_bloc.dart';
import 'package:flutter_youtube_api/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: BlocProvider(
        bloc: FavoriteBloc(),
        child: MaterialApp(
          title: 'YouTube - Flutter',
          theme: ThemeData(),
          debugShowCheckedModeBanner: false,
          home: Home(),
        ),
      ),
    );
  }
}

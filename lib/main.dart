import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/blocs/videos_bloc.dart';
import 'package:flutter_youtube/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: MaterialApp(
        title: 'YouTube - Flutter',
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

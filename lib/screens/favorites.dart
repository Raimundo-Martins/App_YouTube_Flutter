import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/blocs/favorite_bloc.dart';
import 'package:flutter_youtube/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocFavorite = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text('Favoritos'),
          centerTitle: true,
          backgroundColor: Colors.black87),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        initialData: {},
        stream: blocFavorite.outFavorite,
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((video) {
              return InkWell(
                onTap: () {
                  YoutubePlayerController(initialVideoId: video.id);
                },
                onLongPress: () {
                  blocFavorite.toggleFavorite(video);
                },
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 100,
                      child: Image.network(video.thumb),
                    ),
                    Expanded(
                      child: Text(
                        video.title,
                        style: TextStyle(color: Colors.white70),
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

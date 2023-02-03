// import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_preload_videos/bloc/preload_bloc.dart';
import 'package:flutter_preload_videos/service/api_service.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatelessWidget {
  const VideoPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<PreloadBloc, PreloadState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 200,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  itemCount: state.posts.length,
                  scrollDirection: Axis.vertical,
                  onPageChanged: (index) =>
                      BlocProvider.of<PreloadBloc>(context, listen: false)
                          .add(PreloadEvent.onVideoIndexChanged(index)),
                  itemBuilder: (context, index) {
                    // Is at end and isLoading
                    final bool _isLoading =
                        (state.isLoading && index == state.posts.length - 1);

                    return state.focusedIndex == index
                        ? Material(
                            type: MaterialType.transparency,
                            child: GestureDetector(
                              onTap: () async {
                                log('=> \tScreen Tapped!');
                                if (state.isPLaying) {
                                  BlocProvider.of<PreloadBloc>(context,
                                          listen: false)
                                      .add(PreloadEvent.pauseVideo(index));
                                } else {
                                  BlocProvider.of<PreloadBloc>(context,
                                          listen: false)
                                      .add(PreloadEvent.playVideo(index));
                                }
                              },
                              child: Stack(
                                children: [
                                  VideoWidget(
                                    isLoading: _isLoading,
                                    controller: state.controllers[index]!,
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: NetworkImage(state
                                                  .posts[index].userPhotoUrl),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            state.posts[index].userName,
                                            style: TextStyle(
                                              color: Colors.amber.shade900,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      state.posts[index].videoThumbnail),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ),
              TextButton(
                onPressed: () async {
                  BlocProvider.of<PreloadBloc>(context, listen: false)
                      .add(PreloadEvent.resetPosts(state.focusedIndex));

                  // final posts = await ApiService.getPosts();
                  BlocProvider.of<PreloadBloc>(context, listen: false)
                      .add(PreloadEvent.getVideosFromApi());
                },
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "RELOAD POSTS",
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Custom Feed Widget consisting video
class VideoWidget extends StatelessWidget {
  const VideoWidget({
    Key? key,
    required this.isLoading,
    required this.controller,
  });

  final bool isLoading;
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: VideoPlayer(controller),
        ),
        AnimatedCrossFade(
          alignment: Alignment.bottomCenter,
          sizeCurve: Curves.decelerate,
          duration: const Duration(milliseconds: 400),
          firstChild: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CupertinoActivityIndicator(
              color: Colors.white,
              radius: 8,
            ),
          ),
          secondChild: const SizedBox(),
          crossFadeState:
              isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ],
    );
  }
}

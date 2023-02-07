// import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../plugins/video_preloader/bloc/preload_bloc.dart';

class VideoPage extends StatefulWidget {
  const VideoPage();

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<PreloadBloc, PreloadState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 88,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  itemCount: state.posts.length,
                  scrollDirection: Axis.vertical,
                  controller: _pageController,
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

                                  //TODO: Replace with actual Post details widget here...
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
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    state.posts[index].videoThumbnail),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                  },
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    BlocProvider.of<PreloadBloc>(context, listen: false)
                        .add(PreloadEvent.resetPosts(state.focusedIndex));

                    // final posts = await ApiService.getPosts();
                    BlocProvider.of<PreloadBloc>(context, listen: false)
                        .add(PreloadEvent.getVideosFromApi());

                    final oldPageController = _pageController;
                    oldPageController.dispose();
                    setState(() {
                      _pageController = PageController();
                    });
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
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Custom Feed Widget consisting video
class VideoWidget extends StatefulWidget {
  const VideoWidget({
    Key? key,
    required this.isLoading,
    required this.controller,
  });

  final bool isLoading;
  final VideoPlayerController controller;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  double _videoPosition = 0;

  void _videoListener() {
    if (mounted) {
      setState(() {
        _videoPosition = widget.controller.value.position.inMilliseconds /
            widget.controller.value.duration.inMilliseconds;
      });
    }
  }

  @override
  void initState() {
    widget.controller.addListener(_videoListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_videoListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: VideoPlayer(widget.controller),
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
              crossFadeState: widget.isLoading
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          child: AnimatedContainer(
            height: 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  topLeft: Radius.circular(0),
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                color: Colors.amber.shade900),
            width: _videoPosition * MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
          ),
        )
      ],
    );
  }
}

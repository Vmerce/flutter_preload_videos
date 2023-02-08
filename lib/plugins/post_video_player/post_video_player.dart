import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostVideoPlayer extends StatefulWidget {
  const PostVideoPlayer({
    Key? key,
    required this.isLoading,
    required this.controller,
  });

  final bool isLoading;
  final VideoPlayerController controller;

  @override
  State<PostVideoPlayer> createState() => _PostVideoPlayerState();
}

class _PostVideoPlayerState extends State<PostVideoPlayer> {
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

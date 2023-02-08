import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_preload_videos/models/post_model.dart';
import 'package:flutter_preload_videos/main.dart';
import 'package:flutter_preload_videos/plugins/video_preloader/service/api_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:video_player/video_player.dart';

import '../core/constants.dart';

part 'preload_bloc.freezed.dart';
part 'preload_event.dart';
part 'preload_state.dart';

@injectable
@prod
class PreloadBloc extends Bloc<PreloadEvent, PreloadState> {
  PreloadBloc() : super(PreloadState.initial());

  @override
  Stream<PreloadState> mapEventToState(
    PreloadEvent event,
  ) async* {
    yield* event.map(setLoading: (e) async* {
      yield state.copyWith(isLoading: true);
    }, getVideosFromApi: (e) async* {
      /// Fetch videos from api
      final List<PostModel> _posts = await ApiService.getPosts();

      // Initialize states
      yield state.copyWith(focusedIndex: 0);
      yield state.copyWith(reloadCounter: 0);
      yield state.copyWith(isLoading: false);
      yield state.copyWith(isPLaying: false);
      yield state.copyWith(posts: []);
      yield state.copyWith(controllers: {});

      state.posts.addAll(_posts);

      /// Initialize 1st video
      await _initializeControllerAtIndex(0);

      /// Play 1st video
      _playControllerAtIndex(0);
      yield state.copyWith(isPLaying: true);

      /// Initialize 2nd video
      await _initializeControllerAtIndex(1);

      yield state.copyWith(reloadCounter: state.reloadCounter + 1);
    },
        // initialize: (e) async* {},
        onVideoIndexChanged: (e) async* {
      /// Condition to fetch new videos
      final bool shouldFetch = (e.index + kPreloadLimit) % kNextLimit == 0 &&
          state.posts.length == e.index + kPreloadLimit;

      if (shouldFetch) {
        createIsolate(e.index);
      }

      /// Next / Prev video decider
      if (e.index > state.focusedIndex) {
        _playNext(e.index);
      } else {
        _playPrevious(e.index);
      }

      yield state.copyWith(focusedIndex: e.index);
    }, updatePosts: (e) async* {
      /// Add new urls to current urls
      state.posts.addAll(e.posts);

      /// Initialize new url
      _initializeControllerAtIndex(state.focusedIndex + 1);

      yield state.copyWith(
          reloadCounter: state.reloadCounter + 1, isLoading: false);
      log('=> \tNEW POST ADDED');
    }, playVideo: (e) async* {
      log('=> \tPlaying video at index: ${e.index}');
      _playControllerAtIndex(e.index);
      yield state.copyWith(isPLaying: true);
    }, pauseVideo: (e) async* {
      log('=> \tStopping video at index: ${e.index}');
      _pauseControllerAtIndex(e.index);
      yield state.copyWith(isPLaying: false);
    }, resetPosts: (e) async* {
      _pauseControllerAtIndex(e.index);
      log('=> \tResetting posts');
      yield state.copyWith(isPLaying: false);
      yield state.copyWith(isLoading: true);
      state.posts.clear();
    }, stopVideoLooping: (e) async* {
      _stopLoopingControllerAtIndex(e.index);
      _disposeControllerAtIndex(e.index);
    });
  }

  void _playNext(int index) {
    /// Stop [index - 1] controller
    _stopControllerAtIndex(index - 1);

    /// Dispose [index - 2] controller
    _disposeControllerAtIndex(index - 2);

    /// Play current video (already initialized)
    _playControllerAtIndex(index);

    /// Initialize [index + 1] controller
    _initializeControllerAtIndex(index + 1);
  }

  void _playPrevious(int index) {
    /// Stop [index + 1] controller
    _stopControllerAtIndex(index + 1);

    /// Dispose [index + 2] controller
    _disposeControllerAtIndex(index + 2);

    /// Play current video (already initialized)
    _playControllerAtIndex(index);

    /// Initialize [index - 1] controller
    _initializeControllerAtIndex(index - 1);
  }

  Future _initializeControllerAtIndex(int index) async {
    if (state.posts.length > index && index >= 0) {
      /// Create new controller
      final VideoPlayerController _controller =
          VideoPlayerController.network(state.posts[index].videoUrl);

      /// Add to [controllers] list
      state.controllers[index] = _controller;

      /// Initialize
      await _controller.initialize();
      await _controller.setLooping(true);

      log('=> \tINITIALIZED $index');
    }
  }

  void _playControllerAtIndex(int index) {
    if (state.posts.length > index && index >= 0) {
      /// Get controller at [index]
      final VideoPlayerController _controller = state.controllers[index]!;

      /// Play controller
      _controller.play();

      log('=> \tPLAYING $index');
    }
  }

  void _stopControllerAtIndex(int index) {
    if (state.posts.length > index && index >= 0) {
      /// Get controller at [index]
      final VideoPlayerController _controller = state.controllers[index]!;

      /// Pause
      _controller.pause();

      /// Reset postiton to beginning
      _controller.seekTo(const Duration());

      log('=> \tSTOPPED $index');
    }
  }

  void _pauseControllerAtIndex(int index) {
    if (state.posts.length > index && index >= 0) {
      /// Get controller at [index]
      final VideoPlayerController _controller = state.controllers[index]!;

      /// Pause
      _controller.pause();

      log('=> \tPAUSED $index');
    }
  }

  void _stopLoopingControllerAtIndex(int index) {
    if (state.posts.length > index && index >= 0) {
      /// Get controller at [index]
      final VideoPlayerController _controller = state.controllers[index]!;

      /// Pause
      _controller.setLooping(false);

      log('=> \tVideo Looping: OFF $index');
    }
  }

  void _disposeControllerAtIndex(int index) {
    if (state.posts.length > index && index >= 0) {
      /// Get controller at [index]
      final VideoPlayerController? _controller = state.controllers[index];

      /// Dispose controller
      _controller?.dispose();

      if (_controller != null) {
        state.controllers.remove(_controller);
      }

      log('=> \tDISPOSED $index');
    }
  }
}

part of 'preload_bloc.dart';

@freezed
class PreloadEvent with _$PreloadEvent {
  const factory PreloadEvent.getVideosFromApi() = _GetVideosFromApi;
  const factory PreloadEvent.setLoading() = _SetLoading;
  const factory PreloadEvent.resetPosts(int index) = _ResetPosts;
  const factory PreloadEvent.pauseVideo(int index) = _PauseVideo;
  const factory PreloadEvent.playVideo(int index) = _PlayVideo;
  const factory PreloadEvent.updatePosts(List<PostModel> posts) = _updatePosts;
  const factory PreloadEvent.onVideoIndexChanged(int index) =
      _OnVideoIndexChanged;
}

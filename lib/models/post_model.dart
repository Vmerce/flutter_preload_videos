// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostModel {
  final String videoUrl;
  final String videoThumbnail;
  final String userName;
  final String userPhotoUrl;
  PostModel({
    required this.videoUrl,
    required this.videoThumbnail,
    required this.userName,
    required this.userPhotoUrl,
  });

  PostModel copyWith({
    String? videoUrl,
    String? videoThumbnail,
    String? userName,
    String? userPhotoUrl,
  }) {
    return PostModel(
      videoUrl: videoUrl ?? this.videoUrl,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      userName: userName ?? this.userName,
      userPhotoUrl: userPhotoUrl ?? this.userPhotoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'videoUrl': videoUrl,
      'videoThumbnail': videoThumbnail,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      videoUrl: map['videoUrl'] as String,
      videoThumbnail: map['videoThumbnail'] as String,
      userName: map['userName'] as String,
      userPhotoUrl: map['userPhotoUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(videoUrl: $videoUrl, videoThumbnail: $videoThumbnail, userName: $userName, userPhotoUrl: $userPhotoUrl)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.videoUrl == videoUrl &&
        other.videoThumbnail == videoThumbnail &&
        other.userName == userName &&
        other.userPhotoUrl == userPhotoUrl;
  }

  @override
  int get hashCode {
    return videoUrl.hashCode ^
        videoThumbnail.hashCode ^
        userName.hashCode ^
        userPhotoUrl.hashCode;
  }
}

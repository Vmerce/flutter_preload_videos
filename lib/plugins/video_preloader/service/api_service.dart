import 'package:flutter_preload_videos/models/post_model.dart';
import 'package:flutter_preload_videos/plugins/video_preloader/core/constants.dart';


class ApiService {
  // static final List<String> _videos = [
  //   'https://static.ybhospital.net/test-video-1.mp4',
  //   'https://static.ybhospital.net/test-video-2.mp4',
  //   'https://static.ybhospital.net/test-video-3.mp4',
  //   'https://static.ybhospital.net/test-video-4.mp4',
  //   'https://static.ybhospital.net/test-video-5.mp4',
  //   'https://static.ybhospital.net/test-video-6.mp4',
  // ];

  static final List<PostModel> _posts = [
    PostModel(
        videoUrl:
            'https://firebasestorage.googleapis.com/v0/b/vemerse-project.appspot.com/o/uploads%2Fusers%2Fposts%2FS8WOUABNvYb9Pize7NgvArAk8QN2%2FS8WOUABNvYb9Pize7NgvArAk8QN21674596999153.mp4?alt=media&token=5f6c884d-8ca7-42a0-82ac-87269830787e',
        userName: 'User 1',
        userPhotoUrl: 'https://picsum.photos/400/600?random=1',
        videoThumbnail:
            'https://firebasestorage.googleapis.com/v0/b/vemerse-project.appspot.com/o/uploads%2Fusers%2Fposts%2FS8WOUABNvYb9Pize7NgvArAk8QN2%2FS8WOUABNvYb9Pize7NgvArAk8QN21674597001553.jpg?alt=media&token=ad4eabc9-5e64-4ddf-9e89-a399d80d5a4a'),
    PostModel(
        videoUrl:
            'https://firebasestorage.googleapis.com/v0/b/vemerse-project.appspot.com/o/uploads%2Fusers%2Fposts%2FS8WOUABNvYb9Pize7NgvArAk8QN2%2FS8WOUABNvYb9Pize7NgvArAk8QN21674683378927.mp4?alt=media&token=780b42b6-64cb-4814-ab5a-791820e2e74f',
        userName: 'User 2',
        userPhotoUrl: 'https://picsum.photos/400/600?random=2',
        videoThumbnail:
            'https://firebasestorage.googleapis.com/v0/b/vemerse-project.appspot.com/o/uploads%2Fusers%2Fposts%2FS8WOUABNvYb9Pize7NgvArAk8QN2%2FS8WOUABNvYb9Pize7NgvArAk8QN21674683382063.jpg?alt=media&token=501664a9-9706-4bf6-8d80-a1a4f8707b2e'),
    PostModel(
        videoUrl:
            'https://firebasestorage.googleapis.com/v0/b/vemerse-project.appspot.com/o/uploads%2Fusers%2Fposts%2FS8WOUABNvYb9Pize7NgvArAk8QN2%2FS8WOUABNvYb9Pize7NgvArAk8QN21674683604770.mp4?alt=media&token=e840888b-9c3b-4e80-afb3-8732a492e323',
        userName: 'User 3',
        userPhotoUrl: 'https://picsum.photos/400/600?random=3',
        videoThumbnail:
            'https://firebasestorage.googleapis.com/v0/b/vemerse-project.appspot.com/o/uploads%2Fusers%2Fposts%2FS8WOUABNvYb9Pize7NgvArAk8QN2%2FS8WOUABNvYb9Pize7NgvArAk8QN21674683607836.jpg?alt=media&token=9711b6db-8edf-49f6-ba26-743fd75f7cc2'),
    PostModel(
        videoUrl:
            'https://firebasestorage.googleapis.com/v0/b/vemerse-project.appspot.com/o/uploads%2Fusers%2Fposts%2FS8WOUABNvYb9Pize7NgvArAk8QN2%2FS8WOUABNvYb9Pize7NgvArAk8QN21674768757614.mp4?alt=media&token=bfc667a4-72f1-4aca-a99e-5c9752caa13d',
        userName: 'User 4',
        userPhotoUrl: 'https://picsum.photos/400/600?random=4',
        videoThumbnail:
            'https://firebasestorage.googleapis.com/v0/b/vemerse-project.appspot.com/o/uploads%2Fusers%2Fposts%2FS8WOUABNvYb9Pize7NgvArAk8QN2%2FS8WOUABNvYb9Pize7NgvArAk8QN21674768759712.jpg?alt=media&token=e6e21040-6c9a-4826-ba65-8e9d21bf3f6e'),
    PostModel(
        videoUrl:
            'https://firebasestorage.googleapis.com/v0/b/vemerse-project.appspot.com/o/uploads%2Fusers%2Fposts%2FWKPtOMNv0vVeMCrUpJ11KBuVnYh1%2FWKPtOMNv0vVeMCrUpJ11KBuVnYh11674502392810.mp4?alt=media&token=dbd7a4f0-8030-4584-8fd9-6389ac93efda',
        userName: 'User 5',
        userPhotoUrl: 'https://picsum.photos/400/600?random=5',
        videoThumbnail:
            'https://firebasestorage.googleapis.com/v0/b/vemerse-project.appspot.com/o/uploads%2Fusers%2Fposts%2FWKPtOMNv0vVeMCrUpJ11KBuVnYh1%2FWKPtOMNv0vVeMCrUpJ11KBuVnYh11674502397162.jpg?alt=media&token=128992e4-fa69-4e25-8a25-2d62fc5dab38'),
    PostModel(
        videoUrl:
            'https://firebasestorage.googleapis.com/v0/b/vemerse-project.appspot.com/o/uploads%2Fusers%2Fposts%2FWKPtOMNv0vVeMCrUpJ11KBuVnYh1%2FWKPtOMNv0vVeMCrUpJ11KBuVnYh11674581172994.mp4?alt=media&token=3ecb8073-f231-4742-bdbd-8edf845e1be5',
        userName: 'User 6',
        userPhotoUrl: 'https://picsum.photos/400/600?random=6',
        videoThumbnail:
            'https://firebasestorage.googleapis.com/v0/b/vemerse-project.appspot.com/o/uploads%2Fusers%2Fposts%2FWKPtOMNv0vVeMCrUpJ11KBuVnYh1%2FWKPtOMNv0vVeMCrUpJ11KBuVnYh11674581175082.jpg?alt=media&token=6943d9ab-4d3e-4e51-a06e-175f445d62c6'),
  ];

  static Future<List<PostModel>> getPosts({int id = 0}) async {
    // No more posts
    if ((id >= _posts.length)) {
      return [];
    }

    _posts.shuffle();

    await Future.delayed(const Duration(milliseconds: kLatency));

    if ((id + kNextLimit >= _posts.length)) {
      return _posts.sublist(id, _posts.length);
    }

    return _posts.sublist(id, id + kNextLimit);
  }
}

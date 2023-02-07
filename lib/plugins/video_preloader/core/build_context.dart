import 'package:flutter/material.dart';
import 'package:flutter_preload_videos/injection.dart';
import 'package:flutter_preload_videos/plugins/video_preloader/service/navigation_service.dart';


/// Global BuildContext
final BuildContext context =
    getIt<NavigationService>().navigationKey.currentContext!;

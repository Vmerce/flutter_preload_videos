import 'package:flutter/material.dart';
import 'package:flutter_preload_videos/injection.dart';
import 'package:flutter_preload_videos/plugins/preloader/service/navigation_service.dart';


/// Global BuildContext
final BuildContext context =
    getIt<NavigationService>().navigationKey.currentContext!;

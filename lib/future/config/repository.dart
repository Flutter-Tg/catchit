import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/resources/data_state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ConfigRepository {
  final configDB = FirebaseDatabase.instance.ref('app_config');

  Future<DataState<String>> fetchConfig() async {
    try {
      final snapshot = await configDB.get().timeout(AppConfig.timeout);
      if (snapshot.exists) {
        Map value = snapshot.value as Map;
        ApiConfig.instagram1 = value['apis']
            ['instagram_downloader_download_instagram_videos_stories'];
        ApiConfig.facebook1 =
            value['apis']['facebook_reel_and_video_downloader'];
        ApiConfig.tiktok1 = value['apis']
            ['tikTok_downloader_download_tikTok_videos_without_watermark'];
        ApiConfig.tiktok2 = value['apis']['tokApi'];
        ApiConfig.tiktok3 = value['apis']['tiktok_download_without_watermark'];
        ApiConfig.tiktok4 = value['apis']['tiktok_video_no_watermark'];
        ApiConfig.tiktok5 = value['apis']['tiktok_full_info_without_watermark'];
        BannerConfig.openApp = value['banners']['openApp'];
        BannerConfig.exit = value['banners']['exit'];
        BannerConfig.main = value['banners']['main'];
        BannerConfig.history = value['banners']['history'];
        BannerConfig.download = value['banners']['download'];
        return const DataSuccess('');
      } else {
        return const DataFailed('server');
      }
    } catch (e) {
      debugPrint('error : $e');
      if (e.toString().contains('TimeoutException')) {
        return const DataFailed('network');
      } else {
        return const DataFailed('server');
      }
    }
  }
}

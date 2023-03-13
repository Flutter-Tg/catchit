import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/resources/data_state.dart';
import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ConfigRepository {
  Future<DataState<String>> fetchConfig() async {
    try {
      final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
      final xxx = await FirebaseRemoteConfig.instance.fetchAndActivate();
      print("------------------------------------");
      print(xxx);
      print(remoteConfig.getString('rapidApiKey'));
      AppConfig.apiKey = remoteConfig.getString('apiKey');
      Response response = await Dio()
          .get("https://catchit.iran.liara.run/api/v1/config/getall");
      if (response.statusCode == 200) {
        final value = response.data;
        ApiConfig.instagram1 = value['apis'][0]['active'];
        ApiConfig.facebook1 = value['apis'][1]['active'];
        ApiConfig.tiktok1 = value['apis'][2]['active'];
        ApiConfig.tiktok2 = value['apis'][3]['active'];
        ApiConfig.tiktok3 = value['apis'][4]['active'];
        ApiConfig.tiktok4 = value['apis'][5]['active'];
        ApiConfig.tiktok5 = value['apis'][6]['active'];
        BannerConfig.openApp = false; // value['banners'][0]['active'];
        BannerConfig.main = value['banners'][1]['active'];
        BannerConfig.history = value['banners'][2]['active'];
        BannerConfig.download = value['banners'][3]['active'];
        saveToDb();
        return const DataSuccess('');
      } else {
        await getfromDb();
        return const DataFailed('server');
      }
    } catch (e) {
      await getfromDb();
      debugPrint('error : $e');
      if (e.toString().contains('TimeoutException')) {
        return const DataFailed('network');
      } else {
        return const DataFailed('server');
      }
    }
  }

  Future saveToDb() async {
    await Hive.openBox('config');
    final hive = Hive.box('config');
    await hive.put(
      'config',
      {
        'apiKey': AppConfig.apiKey,
        'instagram1': ApiConfig.instagram1,
        'facebook1': ApiConfig.facebook1,
        'tiktok1': ApiConfig.tiktok1,
        'tiktok2': ApiConfig.tiktok2,
        'tiktok3': ApiConfig.tiktok3,
        'tiktok4': ApiConfig.tiktok4,
        'tiktok5': ApiConfig.tiktok5,
        'openApp': BannerConfig.openApp,
        'main': BannerConfig.main,
        'history': BannerConfig.history,
        'download': BannerConfig.download,
      },
    );
    await hive.close();
  }

  Future getfromDb() async {
    await Hive.openBox('config');
    final hive = Hive.box('config');
    final config = await hive.get('config');
    if (config != null) {
      AppConfig.apiKey = config['apiKey'];
      ApiConfig.instagram1 = config['instagram1'];
      ApiConfig.facebook1 = config['facebook1'];
      ApiConfig.tiktok1 = config['tiktok1'];
      ApiConfig.tiktok2 = config['tiktok2'];
      ApiConfig.tiktok3 = config['tiktok3'];
      ApiConfig.tiktok4 = config['tiktok4'];
      ApiConfig.tiktok5 = config['tiktok5'];
      BannerConfig.openApp = config['openApp'];
      BannerConfig.main = config['main'];
      BannerConfig.history = config['history'];
      BannerConfig.download = config['download'];
    }
    await hive.close();
  }
}

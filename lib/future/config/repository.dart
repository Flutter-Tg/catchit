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
        ApiConfig.tiktok1 = value['apis']['tiktok1'];
        ApiConfig.tiktok2 = value['apis']['tiktok2'];
        ApiConfig.tiktok3 = value['apis']['tiktok3'];
        ApiConfig.tiktok4 = value['apis']['tiktok4'];
        ApiConfig.tiktok5 = value['apis']['tiktok5'];
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

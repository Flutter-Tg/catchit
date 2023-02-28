import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateService {
  Dio dio = Dio();

  Future<bool> checkNewVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int currentVersion = int.parse(packageInfo.version.replaceAll('.', ''));
    String packageName = packageInfo.packageName;
    if (Platform.isAndroid) {
      return await checkPlayStore(currentVersion, packageName);
    } else if (Platform.isIOS) {
      return await checkAppleStore(currentVersion, packageName);
    } else {
      return false;
    }
  }

  Future<bool> checkPlayStore(int currentVersion, String packageName) async {
    try {
      final uri = Uri.https(
          "play.google.com", "/store/apps/details", {"id": packageName});
      final response = await dio.getUri(uri);
      if (response.statusCode == 200) {
        final newVersion = RegExp(r',\[\[\["([0-9,\.]*)"]],')
            .firstMatch(response.data)!
            .group(1);
        int newV = int.parse(newVersion.toString().replaceAll('.', ''));
        if (newV > currentVersion) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('checkPlayStore : error = $e');
      return false;
    }
  }

  Future<bool> checkAppleStore(int currentVersion, String packageName) async {
    try {
      var uri =
          Uri.https("itunes.apple.com", "/lookup", {"bundleId": packageName});
      final response = await dio.getUri(uri);
      if (response.statusCode == 200) {
        final jsonObj = jsonDecode(response.data);
        final List results = jsonObj['results'];
        if (results.isNotEmpty) {
          final newVersion = jsonObj['results'][0]['version'];
          int newV = int.parse(newVersion.toString().replaceAll('.', ''));
          if (newV > currentVersion) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('checkAppleStore : error = $e');
      return false;
    }
  }
}

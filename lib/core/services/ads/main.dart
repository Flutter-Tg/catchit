import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class MainNativeAdHelper {
  static NativeAd? nativeAd;
  static bool initialized = false;
  static String get unitId {
    // if (kReleaseMode) {
    //   if (Platform.isAndroid) {
    //     return '';
    //   } else {
    //     return '';
    //   }
    // } else {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/2247696110';
    } else {
      return 'ca-app-pub-3940256099942544/3986624511';
    }
    // }
  }
}

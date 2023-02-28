import 'dart:io';

class AdsService {
  // static String get testbannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/6300978111';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/2934735716';
  //   } else {
  //     throw UnsupportedError('Unsupported platform');
  //   }
  // }

  // static String get testrewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "ca-app-pub-3940256099942544/5224354917";
  //   } else if (Platform.isIOS) {
  //     return "ca-app-pub-3940256099942544/1712485313";
  //   } else {
  //     throw UnsupportedError("Unsupported platform");
  //   }
  // }

  static String get banner1AdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2696089998236396/4317090358';
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_BANNER_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // static String get banner2AdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-2696089998236396/4317090358';
  //   } else if (Platform.isIOS) {
  //     return '<YOUR_IOS_BANNER_AD_UNIT_ID>';
  //   } else {
  //     throw UnsupportedError('Unsupported platform');
  //   }
  // }

  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-2696089998236396/8993582406';
  //   } else if (Platform.isIOS) {
  //     return '<YOUR_IOS_REWARDED_AD_UNIT_ID>';
  //   } else {
  //     throw UnsupportedError('Unsupported platform');
  //   }
  // }
}

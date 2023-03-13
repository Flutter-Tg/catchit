import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConfig {
  static String apiKey = '01612b7d4cmsh25ca5b4c50ef1e0p12586cjsnb29f99843840';
  static const String appVersion = '1.6.2';
  static const String googlePalyLink =
      'https://play.google.com/store/apps/details?id=com.catchit.app';

  //? app primary colors
  static const Color black = Color(0xff101010);
  static const Color blackGray = Color(0xff181818);
  static const Color red = Color(0xffB62222);
  static const Color lightRed = Color(0xffFF3838);
  static const Color gray = Color(0xff474747);
  static const Color lightGray = Color(0xffC1C1C1);

  //? primary font family
  static const String ffIanter = 'Inter';

//? primary fonts size
  double fsSub = 10.sp;
  double fsSmall = 12.sp;
  double fsTextSmall = 13.sp;
  double fsText = 14.sp;
  double fsTitleSmall = 16.sp;
  double fsTitle = 18.sp;
  double fsTitrSub = 20.sp;
  double fsTitrSmall = 22.sp;
  double fsTitr = 24.sp;
  double fsBannerSmall = 32.sp;
  double fsBanner = 36.sp;

  static const Duration timeout = Duration(seconds: 20);
}

class ApiConfig {
  static bool instagram1 = true;
  static bool facebook1 = true;
  static bool tiktok1 = true;
  static bool tiktok2 = true;
  static bool tiktok3 = true;
  static bool tiktok4 = true;
  static bool tiktok5 = true;
}

class BannerConfig {
  static bool openApp = false;
  static bool exit = false;
  static bool main = false;
  static bool history = false;
  static bool download = false;
}

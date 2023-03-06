import 'dart:io';

import 'package:catchit/core/utils/global_state/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:catchit/config/theme.dart';
import 'package:catchit/core/helper/disable_certificate_https.dart';
import 'package:catchit/core/locator/locator.dart';
import 'package:catchit/core/services/notification.dart';
import 'package:catchit/config/app_config.dart';

import 'firebase_options.dart';

void main() async {
  await setup();
  runApp(const ProviderScope(child: CatchitApp()));
}

class CatchitApp extends ConsumerWidget {
  const CatchitApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routerProvider);
    return ScreenUtilInit(
      rebuildFactor: (old, data) {
        if (RebuildFactors.orientation(old, data)) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: darkTheme,
          themeMode: ThemeMode.dark,
          routerConfig: router,
          builder: (context, child) {
            ScreenUtil.init(context, designSize: designSize(Size(1.sw, 1.sh)));
            return child as Widget;
          },
        );
      },
    );
  }
}

Future setup() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // system
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    if (kDebugMode) DeviceOrientation.landscapeLeft,
    if (kDebugMode) DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: AppConfig.black,
  ));

  //native splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // disable cerificate https
  HttpOverrides.global = DisableCertificateHttps();

  //hive
  await Hive.initFlutter();
  await Hive.openBox('Review');

  // fierbase core
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    debugPrint(e.toString());
  }

  // try {
  //   Flurry.builder
  //       .withCrashReporting(true)
  //       .withLogEnabled(true)
  //       .withLogLevel(LogLevel.debug)
  //       .withReportLocation(true)
  //       .build(androidAPIKey: "372DGRGG8STWJCSPZFB2", iosAPIKey: "");
  // } catch (e) {
  //   debugPrint(e.toString());
  // }

  //! ads
  // if (kReleaseMode) {
  //   MobileAds.instance.initialize();
  // } else {
  //   MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
  //       testDeviceIds: ['2A4A033DE1974992A0D05292F33E341C']));
  // }

  //! notification
  if (Platform.isIOS && kDebugMode) {
  } else {
    await NotificationService().setup();
  }

  //locators
  await locatorSetup();
}

Size designSize(Size screenSize) {
  final maxWith = screenSize.width;
  Size size;
  if (maxWith <= 640) {
    size = const Size(393, 852);
    debugPrint('mobile');
  } else if (maxWith <= 1024) {
    size = const Size(1024, 768);
    debugPrint('tablet');
  } else if (maxWith <= 1366) {
    size = const Size(1366, 768);
    debugPrint('laptop');
  } else {
    size = const Size(1920, 1080);
    debugPrint('desktop');
  }

  return size;
}

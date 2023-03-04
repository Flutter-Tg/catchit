import 'package:catchit/core/utils/global_widgets/modals/exit_modal.dart';
import 'package:catchit/core/utils/global_widgets/screen_head.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:catchit/screens/main/main_controller.dart';
import 'package:catchit/screens/main/widgets/zoom_drawer.dart';

import 'pages/about_us/about_us_page.dart';
import 'pages/home/home_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> pages = [
      const HomeScreen(),
      const AboutUsPage(),
    ];
    return WillPopScope(
      onWillPop: () async {
        if (ref.read(zoomDrawerKeyProvider).currentState!.isMenuOpen) {
          ref.read(zoomDrawerKeyProvider).currentState!.closeDrawer();
        } else if (ref.read(pageIndexProvider) == 1) {
          ref.read(pageIndexProvider.notifier).state = 0;
        } else {
          exitModal(context: context);
        }
        return false;
      },
      child: ScreenHead(
        child: ZoomDrawer(
          key: ref.read(zoomDrawerKeyProvider),
          child: Consumer(
            builder: (context, ref, child) {
              return IndexedStack(
                index: ref.watch(pageIndexProvider),
                children: pages,
              );
            },
          ),
        ),
      ),
    );
  }
}

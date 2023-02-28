import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/items/recent_item.dart';
import 'package:catchit/future/history/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RecentList extends ConsumerWidget {
  const RecentList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recent = ref.watch(historyProvider).getRecent();
    if (recent.isNotEmpty) {
      return Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recents',
                  style: TextStyle(
                    fontSize: ThemeConstants().fsTitrSub,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () => ref.read(routerProvider).goNamed('history'),
                  child: Text(
                    'View All',
                    style: TextStyle(
                      fontSize: ThemeConstants().fsText,
                      fontWeight: FontWeight.w500,
                      color: ThemeConstants.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 185,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              itemCount: recent.length,
              itemBuilder: (context, index) => index < 9
                  ? Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () => ref.read(routerProvider).pushNamed(
                              'detail',
                              extra: recent[index],
                            ),
                        child: RecentItem(
                          detail: recent[index],
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: InkWell(
                          onTap: () =>
                              ref.read(routerProvider).goNamed('history'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'see other',
                                style: TextStyle(
                                  fontSize: ThemeConstants().fsText,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeConstants.gray,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15.sp,
                                color: ThemeConstants.gray,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}

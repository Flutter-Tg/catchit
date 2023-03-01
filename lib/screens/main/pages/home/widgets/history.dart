import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/items/history_item.dart';
import 'package:catchit/future/history/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryList extends ConsumerWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider).history;
    if (history.isNotEmpty) {
      return Column(
        children: [
          SizedBox(height: 10.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'History',
                  style: TextStyle(
                    fontSize: AppConfig().fsTitrSub,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () => ref.read(routerProvider).goNamed('history'),
                  child: Text(
                    'View All',
                    style: TextStyle(
                      fontSize: AppConfig().fsText,
                      fontWeight: FontWeight.w500,
                      color: AppConfig.lightRed,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.w),
          SizedBox(
            height: 120.w,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
              itemCount: history.length,
              itemBuilder: (context, index) => index < 9
                  ? Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: HistoryItem(
                        file: history[index],
                      ),
                    )
                  : Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 100.w,
                        height: 100.w,
                        child: InkWell(
                          onTap: () =>
                              ref.read(routerProvider).goNamed('history'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'see other',
                                style: TextStyle(
                                  fontSize: AppConfig().fsText,
                                  fontWeight: FontWeight.w500,
                                  color: AppConfig.gray,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15.sp,
                                color: AppConfig.gray,
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

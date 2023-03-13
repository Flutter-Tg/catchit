import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/services/ads/history_interstitial.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/items/history_item.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/future/history/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryList extends ConsumerWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider).history;
    return Column(
      children: [
        SizedBox(height: 10.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'History',
                style: TextStyle(
                  fontSize: AppConfig().fsTitrSub,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (history.isNotEmpty) const ViewMoreBtn(),
            ],
          ),
        ),
        SizedBox(height: 10.w),
        if (history.isEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
              child: Text(
                'Your history are empty. After catch and downloading the file, you can find them here.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: AppConfig().fsSmall,
                  color: const Color(0xffD3D3D3),
                ),
              ),
            ),
          )
        else
          SizedBox(
            height: 120.w,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: history.length,
              separatorBuilder: (context, index) => SizedBox(width: 20.w),
              itemBuilder: (context, index) => index < 9
                  ? SizedBox(
                      width: 120.w,
                      child: HistoryItem(file: history[index]),
                    )
                  : Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 100.w,
                        height: 120.w,
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
  }
}

class ViewMoreBtn extends ConsumerStatefulWidget {
  const ViewMoreBtn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewMoreBtnState();
}

class _ViewMoreBtnState extends ConsumerState<ViewMoreBtn> {
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() => inProgress = true);
        if (BannerConfig.history) {
          await HistoryInterstitialHelper().loadAd();
        }
        ref.read(routerProvider).goNamed('history');
        setState(() => inProgress = false);
      },
      child: SizedBox(
        height: 20.w,
        child: Center(
          child: inProgress
              ? SizedBox(
                  width: 20.w,
                  child: const CircularProgressIndicator(
                    color: AppConfig.lightRed,
                    strokeWidth: 3,
                  ),
                )
              : Text(
                  "View All",
                  style: TextStyle(
                    fontSize: AppConfig().fsTitleSmall,
                    fontWeight: FontWeight.w500,
                    color: AppConfig.lightRed,
                  ),
                ),
        ),
      ),
    );
  }
}

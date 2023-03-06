import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/modals/clean_history_modal.dart';
import 'package:catchit/core/utils/global_widgets/modals/delete_item_modal.dart';
import 'package:catchit/core/utils/global_widgets/screen_head.dart';
import 'package:catchit/future/history/domain/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_widgets/appbar_widget.dart';
import 'package:catchit/core/utils/global_widgets/items/history_item.dart';
import 'package:catchit/core/utils/global_widgets/show_delay.dart';
import 'package:catchit/future/history/controller.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<FileEntity> selected = [];
  bool isSelected = false;

  clearSelected() {
    setState(() {
      selected = [];
      isSelected = false;
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    isSelected = false;
    selected.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(historyProvider).history;
    final audios =
        history.where((element) => element.format == "audio").toList();
    final other =
        history.where((element) => element.format != "audio").toList();
    return ScreenHead(
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppBarWidget(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              leftChild: AnimatedCrossFade(
                firstChild: InkWell(
                  onTap: () => ref.read(routerProvider).pop(),
                  child: Icon(Icons.arrow_back_ios_outlined, size: 26.sp),
                ),
                secondChild: InkWell(
                  onTap: () => clearSelected(),
                  child: Icon(Icons.close, size: 26.sp),
                ),
                crossFadeState: isSelected
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
              centerChild: Text(
                'History',
                style: TextStyle(
                  fontSize: AppConfig().fsTitleSmall,
                  fontWeight: FontWeight.w600,
                ),
              ),
              rightChild: AnimatedCrossFade(
                firstChild: InkWell(
                  onTap: () async {
                    final result = await cleanHistoryModal(context: context);
                    if (result == true) {
                      clearSelected();
                    }
                  },
                  child: Text(
                    'Clean',
                    style: TextStyle(
                      fontSize: AppConfig().fsTitleSmall,
                      fontWeight: FontWeight.w400,
                      color: AppConfig.lightGray,
                    ),
                  ),
                ),
                secondChild: InkWell(
                  onTap: () async {
                    final result = await deleteItemModal(
                        context: context, files: selected);
                    if (result == true) {
                      clearSelected();
                    }
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: AppConfig().fsTitleSmall,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    ),
                  ),
                ),
                crossFadeState: isSelected
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ),
          ),
          Expanded(
            child: ShowDelay(
              child: Consumer(
                builder: (context, ref, child) {
                  if (history.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 350.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border:
                                    Border.all(width: 2, color: AppConfig.red),
                              ),
                              child: TabBar(
                                controller: tabController,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.white,
                                labelStyle: TextStyle(
                                  fontSize: AppConfig().fsText,
                                  fontWeight: FontWeight.w600,
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorColor: AppConfig.red,
                                indicator:
                                    const BoxDecoration(color: AppConfig.red),
                                tabs: const [
                                  Tab(
                                    text: "Picture / Video",
                                  ),
                                  Tab(text: "Audio"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.w),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              GridView.builder(
                                itemCount: other.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  // mainAxisExtent: 190.w,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 5.w,
                                  mainAxisSpacing: 5.w,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    if (isSelected) {
                                      if (selected.contains(other[index])) {
                                        selected.remove(other[index]);
                                        if (selected.isEmpty) {
                                          isSelected = false;
                                        }
                                      } else {
                                        selected.add(other[index]);
                                      }
                                      setState(() {});
                                    } else {
                                      ref.read(routerProvider).pushNamed(
                                          'detail',
                                          extra: other[index]);
                                    }
                                  },
                                  onLongPress: () => setState(() {
                                    HapticFeedback.vibrate();
                                    selected.clear();
                                    isSelected = true;
                                    selected.add(other[index]);
                                  }),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 50),
                                    padding: EdgeInsets.all(7.w),
                                    decoration: BoxDecoration(
                                      color: selected.contains(other[index])
                                          ? AppConfig.blackGray
                                          : null,
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                          width: 1,
                                          color: selected.contains(other[index])
                                              ? Colors.blueAccent
                                              : Colors.transparent),
                                    ),
                                    child: HistoryItem(file: other[index]),
                                  ),
                                ),
                              ),
                              GridView.builder(
                                itemCount: audios.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  // mainAxisExtent: 190.w,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 5.w,
                                  mainAxisSpacing: 5.w,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    if (isSelected) {
                                      if (selected.contains(audios[index])) {
                                        selected.remove(audios[index]);
                                        if (selected.isEmpty) {
                                          isSelected = false;
                                        }
                                      } else {
                                        selected.add(audios[index]);
                                      }
                                      setState(() {});
                                    } else {
                                      ref.read(routerProvider).pushNamed(
                                          'detail',
                                          extra: audios[index]);
                                    }
                                  },
                                  onLongPress: () => setState(() {
                                    HapticFeedback.vibrate();
                                    selected.clear();
                                    isSelected = true;
                                    selected.add(audios[index]);
                                  }),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 50),
                                    padding: EdgeInsets.all(7.w),
                                    decoration: BoxDecoration(
                                      color: selected.contains(audios[index])
                                          ? AppConfig.blackGray
                                          : null,
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              selected.contains(audios[index])
                                                  ? AppConfig.lightRed
                                                  : Colors.transparent),
                                    ),
                                    child: HistoryItem(file: audios[index]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40.w),
                        Text(
                          'There is nothing yet.',
                          style: TextStyle(
                            fontSize: AppConfig().fsTitr,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff585858),
                          ),
                        ),
                        SizedBox(height: 10.w),
                        Text(
                          'After catch the file you can see your History here..',
                          style: TextStyle(
                            fontSize: AppConfig().fsSmall,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff585858),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

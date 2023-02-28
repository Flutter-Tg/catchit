import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/modals/clean_history_modal.dart';
import 'package:catchit/core/utils/global_widgets/modals/delete_item_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:catchit/core/utils/global_widgets/appbar_widget.dart';
import 'package:catchit/core/utils/global_widgets/items/recent_item.dart';
import 'package:catchit/core/utils/global_widgets/show_delay.dart';
import 'package:catchit/future/history/controller.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  List<int> selected = [];
  bool isSelected = false;

  clearSelected() {
    setState(() {
      selected = [];
      isSelected = false;
    });
  }

  @override
  void dispose() {
    isSelected = false;
    selected.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: AppBarWidget(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
              'Recents',
              style: TextStyle(
                fontSize: ThemeConstants().fsTitleSmall,
                fontWeight: FontWeight.w600,
              ),
            ),
            rightChild: AnimatedCrossFade(
              firstChild: InkWell(
                onTap: () async {
                  cleanHistoryModal(context: context);
                  final result = await cleanHistoryModal(context: context);
                  if (result == true) {
                    clearSelected();
                  }
                },
                child: Text(
                  'Clean',
                  style: TextStyle(
                    fontSize: ThemeConstants().fsTitleSmall,
                    fontWeight: FontWeight.w400,
                    color: ThemeConstants.lightGray,
                  ),
                ),
              ),
              secondChild: InkWell(
                onTap: () async {
                  final result =
                      await deleteItemModal(context: context, ids: selected);
                  if (result == true) {
                    clearSelected();
                  }
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: ThemeConstants().fsTitleSmall,
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
                final history = ref.watch(historyProvider).history;
                if (history.isNotEmpty) {
                  return GridView.builder(
                    itemCount: history.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 190,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        if (isSelected) {
                          if (selected.contains(history[index].id)) {
                            selected.remove(history[index].id);
                            if (selected.isEmpty) {
                              isSelected = false;
                            }
                          } else {
                            selected.add(history[index].id as int);
                          }
                          setState(() {});
                        } else {
                          ref
                              .read(routerProvider)
                              .pushNamed('detail', extra: history[index]);
                        }
                      },
                      onLongPress: () => setState(() {
                        HapticFeedback.vibrate();
                        selected.clear();
                        isSelected = true;
                        selected.add(history[index].id as int);
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 50),
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: selected.contains(history[index].id)
                              ? ThemeConstants.blackGray
                              : null,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              width: 1,
                              color: selected.contains(history[index].id)
                                  ? ThemeConstants.green
                                  : Colors.transparent),
                        ),
                        child: RecentItem(
                          detail: history[index],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'There is nothing yet.',
                        style: TextStyle(
                          fontSize: ThemeConstants().fsTitr,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff585858),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'After catch the file you can see your recents here..',
                        style: TextStyle(
                          fontSize: ThemeConstants().fsSmall,
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
    );
  }
}

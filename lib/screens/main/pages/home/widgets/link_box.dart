import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:catchit/config/app_config.dart';

class LinkBox extends StatefulWidget {
  const LinkBox({
    super.key,
    required this.textEditingController,
    required this.function,
  });
  final TextEditingController textEditingController;
  final Future<bool> Function() function;

  @override
  State<LinkBox> createState() => LinkBoxState();
}

class LinkBoxState extends State<LinkBox> {
  bool isLoading = false;
  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
  }

  clean() {
    widget.textEditingController.clear();
    isEmpty = true;
    setState(() {});
  }

  add(String link) async {
    if (isEmpty) {
      widget.textEditingController.text = link;
      isEmpty = false;
      setState(() => isLoading = true);
      final result = await widget.function();
      if (result) {
        widget.textEditingController.clear();
        isEmpty = true;
        setState(() => isLoading = false);
      } else {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(width: 3, color: AppConfig.gray),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: SizedBox(
            height: 55.w,
            child: Row(
              children: [
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () {
                    widget.textEditingController.text = '';
                    setState(() => isEmpty = true);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: const Color.fromRGBO(62, 62, 62, 0.9),
                    ),
                    width: isEmpty ? 0 : 28.w,
                    height: 35.w,
                    child: Center(
                      child: isEmpty
                          ? null
                          : Icon(
                              Icons.cancel,
                              size: 18.sp,
                              color: const Color(0xffB7B7B7),
                            ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: widget.textEditingController,
                    style: TextStyle(
                      fontSize: AppConfig().fsText,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Copy link and paste here...',
                      hintStyle: TextStyle(
                        fontSize: AppConfig().fsText,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff797979),
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (value.isEmpty != isEmpty) {
                        setState(() => isEmpty = value.isEmpty);
                      }
                    },
                  ),
                ),
                SizedBox(width: 120.w)
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: IgnorePointer(
            ignoring: isLoading ? true : false,
            child: InkWell(
              onTap: () async {
                if (isEmpty) {
                  final copyText =
                      await Clipboard.getData(Clipboard.kTextPlain);
                  if (copyText!.text != null) {
                    widget.textEditingController.text =
                        copyText.text.toString();
                    setState(() => isEmpty = false);
                  }
                } else {
                  if (isLoading == false) {
                    setState(() => isLoading = true);
                    final result = await widget.function();
                    setState(() => isLoading = false);
                    if (result) clean();
                  }
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: isEmpty ? const Color(0xff2561A7) : AppConfig.lightRed,
                ),
                child: SizedBox(
                  width: 100.w,
                  child: Center(
                    child: isLoading
                        ? SizedBox(
                            width: 30.w,
                            height: 30.w,
                            child: const CircularProgressIndicator(
                                color: Colors.white),
                          )
                        : Text(
                            isEmpty ? "Paste" : 'Catchit',
                            style: TextStyle(
                              fontSize: AppConfig().fsTitleSmall,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

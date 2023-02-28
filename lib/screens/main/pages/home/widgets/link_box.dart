import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:catchit/core/utils/consts/theme_constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 54,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    color: ThemeConstants.gray,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, left: 3, bottom: 3),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                widget.textEditingController.text = '';
                                setState(() => isEmpty = true);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: Color.fromRGBO(62, 62, 62, 0.9),
                                ),
                                width: isEmpty ? 0 : 28,
                                height: 35,
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
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: widget.textEditingController,
                                style: TextStyle(
                                  fontSize: ThemeConstants().fsText,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Copy link and paste here...',
                                  hintStyle: TextStyle(
                                    fontSize: ThemeConstants().fsText,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff797979),
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() =>
                                      isEmpty = value.isEmpty ? true : false);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IgnorePointer(
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
                      color: isEmpty
                          ? const Color(0xff2561A7)
                          : ThemeConstants.green,
                    ),
                    child: SizedBox(
                      width: 100,
                      child: Center(
                        child: isLoading
                            ? const SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                isEmpty ? "Paste" : 'Catchit',
                                style: TextStyle(
                                  fontSize: ThemeConstants().fsTitleSmall,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

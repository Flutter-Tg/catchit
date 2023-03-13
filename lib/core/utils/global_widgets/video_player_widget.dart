import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:catchit/core/helper/generate_random_string.dart';
import 'package:catchit/core/utils/animations/show_up_fade.dart';
import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/mute.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'network_imag_fade_widget.dart';

class VideoAutoPlayerWidget extends StatefulWidget {
  const VideoAutoPlayerWidget({
    super.key,
    this.width,
    this.height,
    this.radius,
    required this.url,
    this.thump,
    this.play = true,
  });
  final double? width;
  final double? height;
  final double? radius;
  final String? thump;
  final String url;
  final bool play;

  @override
  State<VideoAutoPlayerWidget> createState() => _VideoAutoPlayerWidgetState();
}

class _VideoAutoPlayerWidgetState extends State<VideoAutoPlayerWidget>
    with WidgetsBindingObserver {
  GlobalKey<VideoPlayerWidgetState> key = GlobalKey();
  bool canEffect = true;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        setState(() => canEffect = true);
        break;
      case AppLifecycleState.inactive:
        setState(() => canEffect = false);
        break;
      case AppLifecycleState.paused:
        setState(() => canEffect = false);
        break;
      case AppLifecycleState.detached:
        setState(() => canEffect = false);
        break;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(generateRandomString(16)),
      onVisibilityChanged: (VisibilityInfo info) {
        if (key.currentState != null && widget.play && canEffect) {
          if (info.visibleFraction * 100 > 70) {
            key.currentState!.forcePlay(true);
          } else {
            key.currentState!.forcePlay(false);
          }
        }
      },
      child: VideoPlayerWidget(
        key: key,
        url: widget.url,
        autoPlay: false,
        width: widget.width,
        height: widget.height,
        radius: widget.radius,
        thump: widget.thump,
      ),
    );
  }
}

class VideoPlayerWidget extends ConsumerStatefulWidget {
  const VideoPlayerWidget({
    super.key,
    this.width,
    this.height,
    this.radius,
    required this.url,
    this.thump,
    this.autoPlay = false,
  });
  final double? width;
  final double? height;
  final double? radius;
  final String? thump;
  final String url;
  final bool autoPlay;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends ConsumerState<VideoPlayerWidget>
    with TickerProviderStateMixin {
  late AnimationController controllerAnime;
  late VideoPlayerController controller;
  bool isLoading = false;
  bool play = false;
  bool userPlay = true;
  bool autoPlay = false;
  Timer timer = Timer.periodic(const Duration(seconds: 3), (timer) {});

  @override
  void initState() {
    super.initState();

    autoPlay = widget.autoPlay;
    controllerAnime = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    initializ();
    if (autoPlay == false) {
      controllerAnime.value = 1;
    }
    controller.pause();
  }

  initializ() {
    controller = VideoPlayerController.network(widget.url)
      ..pause()
      ..setLooping(true)
      ..initialize().then((_) {
        if (mounted) setState(() {});
        controller.pause();
        if (autoPlay) {
          play = true;
          controller.play();
        }
        controller.addListener(() {
          // if (play == false && controller.value.isPlaying) {
          //   controller.pause();
          // }

          if (controller.value.hasError) {
            if (kDebugMode) {
              debugPrint(
                  'video error is : ${controller.value.errorDescription}');
            }
            initializ();
          }
          if (isLoading != controller.value.isBuffering) {
            if (mounted) {
              setState(() => isLoading = controller.value.isBuffering);
            }
          }
        });
      }, onError: (err) {
        debugPrint('video player error : $err');
        initializ();
      });
  }

  forcePlay(bool play) {
    if (userPlay) {
      if (controller.value.isInitialized) {
        if (play) {
          playTap();
        } else {
          stopTap();
        }
      } else {
        autoPlay = play;
      }
    }
  }

  playTap() {
    if (controller.value.isPlaying == false || play == false) {
      controller.play();
      if (mounted) setState(() => play = true);
    }
  }

  stopTap() {
    if (controller.value.isPlaying || play) {
      controller.pause();
      if (mounted) setState(() => play = false);
    }
  }

  openController() {
    timer.cancel();
    if (controllerAnime.isCompleted) {
      controllerAnime.reverse();
    } else if (controllerAnime.isDismissed) {
      controllerAnime.forward();
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        openController();
      });
    } else if (controllerAnime.isAnimating) {
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        openController();
      });
    }
  }

  @override
  void dispose() {
    controller.pause();
    controllerAnime.dispose();
    controller.dispose();
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.setVolume(ref.read(muteProvider) ? 0 : 1);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 0)),
      child: ColoredBox(
        color: AppConfig.blackGray,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              if (widget.thump != null &&
                  controller.value.isInitialized == false)
                NetworkImageFadeWidget(
                  imageUrl: widget.thump,
                  radius: 15.r,
                  fit: BoxFit.contain,
                  width: widget.width,
                ),
              if (controller.value.isInitialized)
                AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(
                    controller,
                    key: Key(generateRandomString(16)),
                  ),
                ),
              if (controller.value.isInitialized)
                Positioned.fill(
                  child: ShowUpFadeAnimation(
                    controller: controllerAnime,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0, 0.2],
                          colors: [Colors.black, Colors.transparent],
                        ),
                      ),
                      child: SizedBox(),
                    ),
                  ),
                ),
              if (controller.value.isInitialized)
                Positioned.fill(
                  child: InkWell(
                    onTap: () {
                      openController();
                    },
                    child: const SizedBox(),
                  ),
                ),
              if (controller.value.isInitialized)
                Positioned(
                  bottom: 10,
                  left: 20,
                  right: 10,
                  child: SizedBox(
                    height: 44,
                    child: ShowUpFadeAnimation(
                      controller: controllerAnime,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: VideoPlayerProgressBarWidget(
                                controller: controller),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              if (play) {
                                userPlay = false;
                                stopTap();
                              } else {
                                userPlay = true;
                                playTap();
                              }
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white30),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: SizedBox(
                                height: 44,
                                width: 44,
                                child: Center(
                                  child: Icon(
                                    play
                                        ? Icons.pause
                                        : Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Consumer(builder: (context, ref, child) {
                            final mute = ref.watch(muteProvider);
                            return InkWell(
                              onTap: () {
                                if (mute) {
                                  controller.setVolume(1);
                                  ref
                                      .watch(muteProvider.notifier)
                                      .update(false);
                                } else {
                                  controller.setVolume(0);
                                  ref.watch(muteProvider.notifier).update(true);
                                }
                              },
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.white30),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                ),
                                child: SizedBox(
                                  height: 44,
                                  width: 44,
                                  child: Center(
                                    child: Icon(
                                      mute
                                          ? Icons.volume_off_rounded
                                          : Icons.volume_up_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              if (controller.value.isInitialized == false || isLoading)
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppConfig.gray.withOpacity(0.2),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        color: AppConfig.lightGray,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerProgressBarWidget extends StatefulWidget {
  const VideoPlayerProgressBarWidget({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  State<VideoPlayerProgressBarWidget> createState() =>
      _VideoPlayerProgressBarWidgetState();
}

class _VideoPlayerProgressBarWidgetState
    extends State<VideoPlayerProgressBarWidget> {
  Duration buffering = Duration.zero;

  @override
  void initState() {
    widget.controller.addListener(() {
      if (mounted) {
        for (final DurationRange range in widget.controller.value.buffered) {
          final Duration end = range.end;
          if (end > buffering) {
            buffering = end;
          }
        }
        if (mounted) setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      progress: widget.controller.value.position,
      buffered: buffering,
      total: widget.controller.value.duration,
      onSeek: (duration) {
        widget.controller.seekTo(duration);
      },
      barHeight: 4,
      baseBarColor: const Color(0xff2F2F2F).withOpacity(0.5),
      progressBarColor: Colors.blueAccent,
      thumbColor: Colors.white,
      timeLabelLocation: TimeLabelLocation.sides,
      timeLabelType: TimeLabelType.totalTime,
      timeLabelTextStyle: TextStyle(
        fontSize: AppConfig().fsSmall,
        fontWeight: FontWeight.w400,
        color: AppConfig.lightGray,
      ),
      bufferedBarColor: Colors.blueAccent.withOpacity(0.3),
    );
  }
}

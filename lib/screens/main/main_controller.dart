import 'package:catchit/screens/main/widgets/zoom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final zoomDrawerKeyProvider = StateProvider<GlobalKey<ZoomDrawerState>>(
    (ref) => GlobalKey<ZoomDrawerState>());

final pageIndexProvider = StateProvider<int>((ref) => 0);

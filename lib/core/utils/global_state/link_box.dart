import 'package:catchit/screens/main/pages/home/widgets/link_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final linkBoxProvider = StateProvider<GlobalKey<LinkBoxState>>((ref) {
  return GlobalKey<LinkBoxState>();
});

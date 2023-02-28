import 'package:catchit/config/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = StateProvider<GoRouter>((ref) {
  return baseRouter;
});

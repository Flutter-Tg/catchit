import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:in_app_review/in_app_review.dart';

class ReviewService {
  final InAppReview _inAppReview = InAppReview.instance;

  Future rating() async {
    final hive = Hive.box('Review');
    try {
      dynamic firstRun = await hive.get('firstRun');
      if (firstRun == null) {
        await hive.put('firstRun', 1);
        bool isShowed = await showRating();
        // } else if (firstRun < 7) {
        // await hive.put('firstRun', firstRun + 1);
        // } else if (firstRun == 7) {
        // bool isShowed = await showRating();
        if (isShowed == true) {
          await hive.put('firstRun', 8);
        } else {
          await hive.put('firstRun', null);
        }
      } else {
        dynamic dateNotis = await hive.get('dateNotis');
        final now = DateTime.now();
        if (dateNotis == null) {
          await hive.put('dateNotis', now.add(const Duration(days: 3)));
        } else {
          if (now.isAfter(dateNotis)) {
            bool isShowed = await showRating();
            if (isShowed) {
              hive.put('dateNotis', now.add(const Duration(days: 3)));
            }
          }
        }
      }
    } catch (e) {
      debugPrint('rating : error = $e');
    }
  }

  Future<bool> showRating() async {
    try {
      final available = await _inAppReview.isAvailable();
      if (available) {
        await _inAppReview.requestReview();
      } else {
        await _inAppReview.openStoreListing();
      }
      return true;
    } catch (e) {
      debugPrint('showRating : error = $e');
      return false;
    }
  }
}

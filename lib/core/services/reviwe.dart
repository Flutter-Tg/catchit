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
      } else if (firstRun % 3 == 0) {
        bool isShowed = await showRating();
        if (isShowed) {
          await hive.put('firstRun', firstRun + 1);
        }
      } else {
        await hive.put('firstRun', firstRun + 1);
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

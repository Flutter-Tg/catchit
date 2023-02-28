import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OnboardingService {
  Future<bool> checkSee() async {
    try {
      await Hive.openBox('onboaring');
      var hive = Hive.box('onboaring');
      var status = await hive.get('status');
      if (status == null || status == false) {
        await hive.put('status', true);
        hive.close();
        return false;
      } else {
        hive.close();
        return true;
      }
    } catch (e) {
      debugPrint('checkSee : error = $e');
      return false;
    }
  }
}

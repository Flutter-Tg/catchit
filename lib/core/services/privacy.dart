import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

class PrivacyService {
  Future<bool> checkAcepted() async {
    try {
      await Hive.openBox('Privacy');
      var hive = Hive.box('Privacy');
      var privacy = await hive.get('status');
      bool? result;
      if (privacy != null) {
        if (privacy == true) {
          result = true;
        } else {
          result = false;
        }
      } else {
        result = false;
      }

      await hive.close();
      return result;
    } catch (e) {
      debugPrint('checkAcepted : error = $e');
      return false;
    }
  }

  Future<bool> accept() async {
    try {
      await Hive.openBox('Privacy');
      var hive = Hive.box('Privacy');
      await hive.put('status', true);
      await hive.close();
      return true;
    } catch (e) {
      debugPrint('accept : error = $e');
      return false;
    }
  }
}

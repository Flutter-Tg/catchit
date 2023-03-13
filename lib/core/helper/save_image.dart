import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<String> getImageByt(String url) async {
  final response = await http.get(Uri.parse(url));
  return Utility.base64String(response.bodyBytes).toString();
}

class Utility {
  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}

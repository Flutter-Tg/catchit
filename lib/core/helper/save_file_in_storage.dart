import 'dart:io';

import 'package:catchit/core/params/download_param.dart';
import 'package:flutter/foundation.dart';

import 'app_storage_path.dart';
import 'error_msg.dart';

Future<String?> saveFileInStorage(
    {required DownloadBtnParam param, required File file}) async {
  try {
    String savedPath =
        '${await AppStoragePath().getPath()}/catchit/${param.isAudio ? 'audio' : param.isVideo ? 'video' : 'image'}/?${param.fileName}';
    if (await File(savedPath).exists()) {
      return fileExict;
    } else {
      bool result = await File("$savedPath/").create(recursive: true).then(
        (value) async {
          Uint8List bytes = await file.readAsBytes();
          final val = await value.writeAsBytes(bytes);
          return val.isAbsolute;
        },
      );
      if (result) {
        return savedPath;
      }
    }
    return null;
  } catch (err) {
    if (kDebugMode) print(err);
    return null;
  }
}

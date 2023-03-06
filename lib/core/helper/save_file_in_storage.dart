import 'dart:io';

import 'package:catchit/core/params/download_param.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app_storage_path.dart';
import 'error_msg.dart';

Future<String?> saveFileInStorage(
    {required DownloadBtnParam param, required File file}) async {
  try {
    //  "storage/emulated/0/Download"
    //  (await getExternalStorageDirectory())!.path
    // ${param.isAudio ? 'Audios' : param.isVideo ? 'Videos' : 'Images'}
    Directory savedPath =
        Directory("${await AppStoragePath().getPath()}/${param.fileName}");
    await Permission.storage.request();
    if (await File(savedPath.path).exists()) {
      return fileExict;
    } else {
      bool result = await File(savedPath.path).create(recursive: true).then(
        (value) async {
          Uint8List bytes = await file.readAsBytes();
          final val = await value.writeAsBytes(bytes);
          return val.isAbsolute;
        },
      );
      // print(result);
      if (result) {
        // MediaScanner.loadMedia(path: savedPath.path);
        return savedPath.path;
      }
    }
    return null;
  } catch (err) {
    if (kDebugMode) print(err);
    return null;
  }
}

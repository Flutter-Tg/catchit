import 'dart:io';

import 'package:catchit/core/params/download_param.dart';
import 'package:catchit/core/services/permission.dart';
import 'package:flutter/foundation.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import 'error_msg.dart';

Future<String?> saveFileInStorage(
    {required DownloadBtnParam param, required File file}) async {
  try {
    //  "storage/emulated/0/Download"
    //  (await getExternalStorageDirectory())!.path
    // ${param.isAudio ? 'Audios' : param.isVideo ? 'Videos' : 'Images'}

    Directory savedPath = Directory(
        "${(await getApplicationDocumentsDirectory()).path}/${param.fileName}");
    await storagePermission();

    if (await File(savedPath.path).exists()) {
      GallerySaver.saveImage(savedPath.path, albumName: 'Catchit');
      return fileExict;
    } else {
      bool result = await File(savedPath.path).create(recursive: true).then(
        (value) async {
          Uint8List bytes = await file.readAsBytes();
          final val = await value.writeAsBytes(bytes);
          return val.isAbsolute;
        },
      );
      if (result) {
        GallerySaver.saveImage(file.path, albumName: 'Catchit');
        return savedPath.path;
      }
    }
    return null;
  } catch (err) {
    if (kDebugMode) print(err);
    return null;
  }
}

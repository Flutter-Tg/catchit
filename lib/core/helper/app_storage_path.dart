import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AppStoragePath {
  Future<String> getPath() async {
    Directory directory = Directory('');
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = Directory('/storage/emulated/0/Download');
      if (await directory.exists() == false) {
        directory = (await getExternalStorageDirectory())!;
      }
    }
    // directory = Directory('${directory.path}/Catchit');

    // if (await directory.exists() == false) {
    //   await directory.create();
    // }

    return directory.path;
  }

  Future<String> getCashPath() async {
    String directory = '';
    await Permission.storage.request();
    directory = (await getTemporaryDirectory()).path;
    return directory;
  }
}

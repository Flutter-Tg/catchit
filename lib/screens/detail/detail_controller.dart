import 'dart:io';
import 'package:catchit/core/params/download_param.dart';
import 'package:path_provider/path_provider.dart';

class DetailController {
  Future<String> getPath({required DownloadBtnParam param}) async {
    if (Platform.isAndroid) {
      return param.isAudio
          ? "/storage/emulated/0/Music/Catchit"
          : (await getApplicationDocumentsDirectory()).path;
    } else {
      return (await getApplicationDocumentsDirectory()).path;
    }
  }

  // saveFile(
  //   WidgetRef ref, {
  //   required DownloadBtnParam param,
  //   required File file,
  // }) async {
  //   if (param.isAudio) {
  //     if (await file.exists()) {
  //       return "You already have this file";
  //     } else {
  //       result = await File(donloadPath).create(recursive: true).then(
  //         (value) async {
  //           Uint8List bytes = await file.readAsBytes();
  //           final val = await value.writeAsBytes(bytes);
  //           return val.isAbsolute;
  //         },
  //       );
  //     }
  //   }
  // }

  // Future<String> createFile({
  //   required DownloadBtnParam param,
  //   required File file,
  // }) async {
  //   try {
  //     dynamic result;
  //     if (param.isAudio) {
  //       String donloadPath =
  //           '${await AppStoragePath().getPath()}/${param.fileName}';
  //       File donwloadedFile = File(donloadPath);
  //       if (await donwloadedFile.exists()) {
  //         return "You already have this file";
  //       } else {
  //         result = await File(donloadPath).create(recursive: true).then(
  //           (value) async {
  //             Uint8List bytes = await file.readAsBytes();
  //             final val = await value.writeAsBytes(bytes);
  //             return val.isAbsolute;
  //           },
  //         );
  //       }
  //     } else if (param.isImage) {
  //       result = await GallerySaver.saveImage(file.path);
  //     } else if (param.isVideo) {
  //       result = await GallerySaver.saveVideo(file.path);
  //     }
  //     if (result == true) {
  //       return 'success';
  //     } else {
  //       return "can't saved, try again";
  //     }
  //   } catch (err) {
  //     if (kDebugMode) print(err);
  //     return "can't saved, try again";
  //   }
  // }
}

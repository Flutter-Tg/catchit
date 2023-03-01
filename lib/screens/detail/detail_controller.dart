// import 'dart:io';
// import 'package:catchit/core/helper/app_storage_path.dart';
// import 'package:catchit/core/params/download_param.dart';
// import 'package:flutter/foundation.dart';
// import 'package:gallery_saver/gallery_saver.dart';

// class DetailController {
//   Future<String> createFile({
//     required DownloadBtnParam param,
//     required File file,
//   }) async {
//     try {
//       dynamic result;
//       String donloadPath =
//           '${await AppStoragePath().getPath()}/catchit/${param.fileName}';
//       if (param.isAudio) {
//         String donloadPath =
//             '${await AppStoragePath().getPath()}/${param.fileName}';
//         File donwloadedFile = File(donloadPath);
//         if (await donwloadedFile.exists()) {
//           return "You already have this file";
//         } else {
//           result = await File(donloadPath).create(recursive: true).then(
//             (value) async {
//               Uint8List bytes = await file.readAsBytes();
//               final val = await value.writeAsBytes(bytes);
//               return val.isAbsolute;
//             },
//           );
//         }
//       } else if (param.isImage) {
//         result = await GallerySaver.saveImage(file.path);
//       } else if (param.isVideo) {
//         result = await GallerySaver.saveVideo(file.path);
//       }
//       if (result == true) {
//         return 'success';
//       } else {
//         return "can't saved, try again";
//       }
//     } catch (err) {
//       if (kDebugMode) print(err);
//       return "can't saved, try again";
//     }
//   }
// }

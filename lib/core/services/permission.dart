import 'package:permission_handler/permission_handler.dart';

Future storagePermission() async {
  await Permission.storage.request();
  await Permission.photos.request();
  // await Permission.manageExternalStorage.request();
}

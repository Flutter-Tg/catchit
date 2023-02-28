import 'package:catchit/core/params/file_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class GetFileInfo {
  Dio dio = Dio();

  Future<FileInfoParam?> fileInfo(video) async {
    try {
      final response = await dio.head(video);
      List<String> content =
          response.headers['content-type']![0].toString().split('/');
      return FileInfoParam(
        format: content[0],
        type: content[1],
        size: double.parse(response.headers["content-length"]![0].toString())
            .round(),
      );
    } catch (e) {
      debugPrint('fileInfo : error = $e');
      return null;
    }
  }
}

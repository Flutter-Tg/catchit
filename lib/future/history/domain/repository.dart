import 'package:catchit/core/resources/data_state.dart';

import 'entity.dart';

abstract class HistoryRepository {
  Future<DataState<List<FileEntity>>> getDbFiles();
  Future<DataState<FileEntity>> getFileByLink(String link);
  Future<DataState<dynamic>> addFileToDb(FileEntity fileEntity);
  Future<DataState<dynamic>> deleteDbFiles();
  Future<DataState<dynamic>> deleteDbFile(FileEntity fileEntity);
}

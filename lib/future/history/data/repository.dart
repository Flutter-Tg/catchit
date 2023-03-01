import 'package:catchit/core/resources/data_state.dart';
import 'package:catchit/future/history/data/local/dao.dart';
import 'package:catchit/future/history/domain/entity.dart';
import 'package:catchit/future/history/domain/repository.dart';
import 'package:flutter/foundation.dart';

class HistoryRepositoryImpl extends HistoryRepository {
  FileDao fileDao;
  HistoryRepositoryImpl(this.fileDao);

  @override
  Future<DataState<List<FileEntity>>> getDbFiles() async {
    try {
      List<FileEntity> files = await fileDao.getFiles();
      return DataSuccess(files);
    } catch (e) {
      debugPrint('getDbDetails : error = $e');
      return const DataFailed('error');
    }
  }

  @override
  Future<DataState<FileEntity>> getFileByLink(String link) async {
    try {
      FileEntity? file = await fileDao.getFileByLink(link);
      return DataSuccess(file);
    } catch (e) {
      debugPrint('getDbDetails : error = $e');
      return const DataFailed('error');
    }
  }

  @override
  Future<DataState<dynamic>> addFileToDb(FileEntity fileEntity) async {
    try {
      await fileDao.insertFile(fileEntity);
      return const DataSuccess(null);
    } catch (e) {
      debugPrint('addDetailToDb : error = $e');
      return const DataFailed('error');
    }
  }

  @override
  Future<DataState<dynamic>> deleteDbFiles() async {
    try {
      await fileDao.deleteAllFiles();
      return const DataSuccess(null);
    } catch (e) {
      debugPrint('deleteDbDetails : error = $e');
      return const DataFailed('error');
    }
  }

  @override
  Future<DataState<dynamic>> deleteDbFile(FileEntity fileEntity) async {
    try {
      await fileDao.deleteFile(fileEntity);
      return const DataSuccess(null);
    } catch (e) {
      debugPrint('deleteDbDetail : error = $e');
      return const DataFailed('error');
    }
  }
}

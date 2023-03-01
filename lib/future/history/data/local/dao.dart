import 'package:catchit/future/history/domain/entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class FileDao {
  @Query('SELECT * FROM FileEntity')
  Future<List<FileEntity>> getFiles();

  @Query('SELECT * FROM FileEntity WHERE id = :id')
  Future<FileEntity?> getFileById(int id);

  @Query('SELECT * FROM FileEntity WHERE link = :link')
  Future<FileEntity?> getFileByLink(String link);

  @insert
  Future<void> insertFile(FileEntity detail);

  @update
  Future<void> updateFilebyId(FileEntity newDetail);

  @Query('DELETE FROM FileEntity')
  Future<void> deleteAllFiles();

  @delete
  Future<void> deleteFile(FileEntity fileEntity);
}

import 'package:catchit/future/detail/domain/entity/detail_db.dart';
import 'package:floor/floor.dart';

@dao
abstract class DetailDao {
  @Query('SELECT * FROM DetailDbEntity')
  Future<List<DetailDbEntity>> getAllDetails();

  @Query('SELECT * FROM DetailDbEntity WHERE id = :id')
  Future<DetailDbEntity?> getDetailById(int id);

  @insert
  Future<void> insertDetail(DetailDbEntity detail);

  @update
  Future<void> updateDetailbyId(DetailDbEntity newDetail);

  @Query('DELETE FROM DetailDbEntity WHERE id = :id')
  Future<void> deleteDetailbyId(int id);
}

import 'package:catchit/core/resources/data_state.dart';
import 'package:catchit/future/detail/domain/entity/detail.dart';

abstract class DetailRepository {
  // Future<DataState<List<DetailEntity>>> getDbDetails();
  // Future<DataState<dynamic>> addDetailToDb(DetailEntity detailEntity);
  // Future<DataState<dynamic>> deleteDbDetails();
  // Future<DataState<dynamic>> deleteDbDetail(int id);
  Future<DataState<DetailEntity>> tiktokApi(String link);
  Future<DataState<DetailEntity>> instagramApi(String link);
  Future<DataState<DetailEntity>> facebookApi(String link);
}

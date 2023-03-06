import 'package:catchit/core/resources/data_state.dart';
import 'package:catchit/future/detail/domain/entity/detail.dart';

abstract class DetailRepository {
  Future<DataState<DetailEntity>> tiktokApi(String link);
  Future<DataState<DetailEntity>> instagramApi(String link);
  Future<DataState<DetailEntity>> facebookApi(String link);
}

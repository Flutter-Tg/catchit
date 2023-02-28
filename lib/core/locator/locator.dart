import 'package:get_it/get_it.dart';

import 'package:catchit/future/detail/data_source/local/database.dart';
import 'package:catchit/future/detail/data_source/remote/api_provider.dart';
import 'package:catchit/future/detail/data_source/repository/repository_impl.dart';

GetIt locator = GetIt.instance;
locatorSetup() async {
  final database =
      await $FloorDetailDatabase.databaseBuilder('detail_database.db').build();
  locator.registerSingleton<DetailDatabase>(database);
  locator.registerSingleton<DetailRepositoryImpl>(
      DetailRepositoryImpl(database.detailDao, DetailApiProvider()));
}

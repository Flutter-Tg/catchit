import 'package:catchit/future/history/data/local/database.dart';
import 'package:catchit/future/history/data/repository.dart';
import 'package:get_it/get_it.dart';

import 'package:catchit/future/detail/data_source/api_provider.dart';
import 'package:catchit/future/detail/data_source/repository_impl.dart';

GetIt locator = GetIt.instance;
locatorSetup() async {
  final database = await $FloorHistoryDatabase
      .databaseBuilder('history2_database.db')
      .build();
  locator.registerSingleton<HistoryDatabase>(database);
  locator.registerSingleton<HistoryRepositoryImpl>(
      HistoryRepositoryImpl(database.fileDao));
  locator.registerSingleton<DetailRepositoryImpl>(
      DetailRepositoryImpl(DetailApiProvider()));
}

import 'package:catchit/future/history/data/local/database.dart';
import 'package:catchit/future/history/data/repository.dart';
import 'package:get_it/get_it.dart';

import 'package:catchit/future/detail/data_source/remote/api_provider.dart';
import 'package:catchit/future/detail/data_source/repository/repository_impl.dart';

GetIt locator = GetIt.instance;
locatorSetup() async {
  final database = await $FloorHistoryDatabase
      .databaseBuilder('history_database.db')
      // .addMigrations([historyMigration1])
      .build();
  locator.registerSingleton<HistoryDatabase>(database);
  locator.registerSingleton<HistoryRepositoryImpl>(
      HistoryRepositoryImpl(database.fileDao));
  locator.registerSingleton<DetailRepositoryImpl>(
      DetailRepositoryImpl(DetailApiProvider()));
}

import 'dart:async';

import 'package:catchit/config/app_config.dart';
import 'package:catchit/future/history/domain/entity.dart';
import 'package:floor/floor.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao.dart';

part 'database.g.dart';

@Database(version: AppConfig.fileDbVersion, entities: [FileEntity])
abstract class HistoryDatabase extends FloorDatabase {
  FileDao get fileDao;
}

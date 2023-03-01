import 'dart:async';

import 'package:catchit/config/app_config.dart';
import 'package:floor/floor.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:catchit/future/detail/data_source/local/dao.dart';
import 'package:catchit/future/detail/domain/entity/detail_db.dart';

part 'database.g.dart';

@Database(version: AppConfig.detailDbVersion, entities: [DetailDbEntity])
abstract class DetailDatabase extends FloorDatabase {
  DetailDao get detailDao;
}

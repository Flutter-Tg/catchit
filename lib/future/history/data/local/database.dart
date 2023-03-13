import 'dart:async';

import 'package:catchit/future/history/domain/entity.dart';
import 'package:floor/floor.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [FileEntity])
abstract class HistoryDatabase extends FloorDatabase {
  FileDao get fileDao;
}

// final historyMigration1 = Migration(1, 2, (database) async {
//   await database.execute('ALTER TABLE FileEntity ADD COLUMN thumb TEXT');
// });

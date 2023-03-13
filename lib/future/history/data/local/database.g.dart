// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorHistoryDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$HistoryDatabaseBuilder databaseBuilder(String name) =>
      _$HistoryDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$HistoryDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$HistoryDatabaseBuilder(null);
}

class _$HistoryDatabaseBuilder {
  _$HistoryDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$HistoryDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$HistoryDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<HistoryDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$HistoryDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$HistoryDatabase extends HistoryDatabase {
  _$HistoryDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FileDao? _fileDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FileEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `platform` TEXT NOT NULL, `format` TEXT NOT NULL, `link` TEXT NOT NULL, `file` TEXT NOT NULL, `thumb` TEXT NOT NULL, `title` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FileDao get fileDao {
    return _fileDaoInstance ??= _$FileDao(database, changeListener);
  }
}

class _$FileDao extends FileDao {
  _$FileDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _fileEntityInsertionAdapter = InsertionAdapter(
            database,
            'FileEntity',
            (FileEntity item) => <String, Object?>{
                  'id': item.id,
                  'platform': item.platform,
                  'format': item.format,
                  'link': item.link,
                  'file': item.file,
                  'thumb': item.thumb,
                  'title': item.title
                }),
        _fileEntityUpdateAdapter = UpdateAdapter(
            database,
            'FileEntity',
            ['id'],
            (FileEntity item) => <String, Object?>{
                  'id': item.id,
                  'platform': item.platform,
                  'format': item.format,
                  'link': item.link,
                  'file': item.file,
                  'thumb': item.thumb,
                  'title': item.title
                }),
        _fileEntityDeletionAdapter = DeletionAdapter(
            database,
            'FileEntity',
            ['id'],
            (FileEntity item) => <String, Object?>{
                  'id': item.id,
                  'platform': item.platform,
                  'format': item.format,
                  'link': item.link,
                  'file': item.file,
                  'thumb': item.thumb,
                  'title': item.title
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FileEntity> _fileEntityInsertionAdapter;

  final UpdateAdapter<FileEntity> _fileEntityUpdateAdapter;

  final DeletionAdapter<FileEntity> _fileEntityDeletionAdapter;

  @override
  Future<List<FileEntity>> getFiles() async {
    return _queryAdapter.queryList('SELECT * FROM FileEntity',
        mapper: (Map<String, Object?> row) => FileEntity(
            id: row['id'] as int?,
            platform: row['platform'] as String,
            format: row['format'] as String,
            link: row['link'] as String,
            file: row['file'] as String,
            thumb: row['thumb'] as String,
            title: row['title'] as String));
  }

  @override
  Future<FileEntity?> getFileById(int id) async {
    return _queryAdapter.query('SELECT * FROM FileEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => FileEntity(
            id: row['id'] as int?,
            platform: row['platform'] as String,
            format: row['format'] as String,
            link: row['link'] as String,
            file: row['file'] as String,
            thumb: row['thumb'] as String,
            title: row['title'] as String),
        arguments: [id]);
  }

  @override
  Future<FileEntity?> getFileByLink(String link) async {
    return _queryAdapter.query('SELECT * FROM FileEntity WHERE link = ?1',
        mapper: (Map<String, Object?> row) => FileEntity(
            id: row['id'] as int?,
            platform: row['platform'] as String,
            format: row['format'] as String,
            link: row['link'] as String,
            file: row['file'] as String,
            thumb: row['thumb'] as String,
            title: row['title'] as String),
        arguments: [link]);
  }

  @override
  Future<void> deleteAllFiles() async {
    await _queryAdapter.queryNoReturn('DELETE FROM FileEntity');
  }

  @override
  Future<void> insertFile(FileEntity detail) async {
    await _fileEntityInsertionAdapter.insert(detail, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateFilebyId(FileEntity newDetail) async {
    await _fileEntityUpdateAdapter.update(newDetail, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFile(FileEntity fileEntity) async {
    await _fileEntityDeletionAdapter.delete(fileEntity);
  }
}

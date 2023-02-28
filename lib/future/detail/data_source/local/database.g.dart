// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorDetailDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DetailDatabaseBuilder databaseBuilder(String name) =>
      _$DetailDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DetailDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$DetailDatabaseBuilder(null);
}

class _$DetailDatabaseBuilder {
  _$DetailDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$DetailDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DetailDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<DetailDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$DetailDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DetailDatabase extends DetailDatabase {
  _$DetailDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DetailDao? _detailDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `DetailDbEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `platform` TEXT NOT NULL, `link` TEXT NOT NULL, `title` TEXT NOT NULL, `owner` TEXT, `images` TEXT, `videos` TEXT, `audios` TEXT, `thumb` TEXT, `caption` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DetailDao get detailDao {
    return _detailDaoInstance ??= _$DetailDao(database, changeListener);
  }
}

class _$DetailDao extends DetailDao {
  _$DetailDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _detailDbEntityInsertionAdapter = InsertionAdapter(
            database,
            'DetailDbEntity',
            (DetailDbEntity item) => <String, Object?>{
                  'id': item.id,
                  'platform': item.platform,
                  'link': item.link,
                  'title': item.title,
                  'owner': item.owner,
                  'images': item.images,
                  'videos': item.videos,
                  'audios': item.audios,
                  'thumb': item.thumb,
                  'caption': item.caption
                }),
        _detailDbEntityUpdateAdapter = UpdateAdapter(
            database,
            'DetailDbEntity',
            ['id'],
            (DetailDbEntity item) => <String, Object?>{
                  'id': item.id,
                  'platform': item.platform,
                  'link': item.link,
                  'title': item.title,
                  'owner': item.owner,
                  'images': item.images,
                  'videos': item.videos,
                  'audios': item.audios,
                  'thumb': item.thumb,
                  'caption': item.caption
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DetailDbEntity> _detailDbEntityInsertionAdapter;

  final UpdateAdapter<DetailDbEntity> _detailDbEntityUpdateAdapter;

  @override
  Future<List<DetailDbEntity>> getAllDetails() async {
    return _queryAdapter.queryList('SELECT * FROM DetailDbEntity',
        mapper: (Map<String, Object?> row) => DetailDbEntity(
            id: row['id'] as int?,
            platform: row['platform'] as String,
            link: row['link'] as String,
            title: row['title'] as String,
            owner: row['owner'] as String?,
            thumb: row['thumb'] as String?,
            images: row['images'] as String?,
            videos: row['videos'] as String?,
            audios: row['audios'] as String?,
            caption: row['caption'] as String?));
  }

  @override
  Future<DetailDbEntity?> getDetailById(int id) async {
    return _queryAdapter.query('SELECT * FROM DetailDbEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => DetailDbEntity(
            id: row['id'] as int?,
            platform: row['platform'] as String,
            link: row['link'] as String,
            title: row['title'] as String,
            owner: row['owner'] as String?,
            thumb: row['thumb'] as String?,
            images: row['images'] as String?,
            videos: row['videos'] as String?,
            audios: row['audios'] as String?,
            caption: row['caption'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteDetailbyId(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DetailDbEntity WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertDetail(DetailDbEntity detail) async {
    await _detailDbEntityInsertionAdapter.insert(
        detail, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateDetailbyId(DetailDbEntity newDetail) async {
    await _detailDbEntityUpdateAdapter.update(
        newDetail, OnConflictStrategy.abort);
  }
}

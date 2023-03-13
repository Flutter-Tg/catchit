import 'package:floor/floor.dart';

@entity
class FileEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;

  String platform;
  String format;
  String link;
  String file;
  @ColumnInfo(name: 'thumb')
  String thumb;
  String title;

  FileEntity({
    this.id,
    required this.platform,
    required this.format,
    required this.link,
    required this.file,
    required this.thumb,
    required this.title,
  });
}

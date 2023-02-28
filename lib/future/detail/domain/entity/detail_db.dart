import 'package:floor/floor.dart';

@entity
class DetailDbEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;

  String platform;
  String link;
  String title;
  String? owner;
  String? images;
  String? videos;
  String? audios;
  String? thumb;
  String? caption;

  DetailDbEntity({
    this.id,
    required this.platform,
    required this.link,
    required this.title,
    this.owner,
    this.thumb,
    this.images,
    this.videos,
    this.audios,
    this.caption,
  });
}

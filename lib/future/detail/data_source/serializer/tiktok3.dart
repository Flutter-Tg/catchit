import 'package:catchit/core/helper/error_msg.dart';
import 'package:catchit/core/helper/generate_random_string.dart';
import 'package:catchit/core/helper/save_image.dart';
import 'package:catchit/core/resources/data_state.dart';
import 'package:catchit/future/detail/domain/entity/detail.dart';
import 'package:dio/dio.dart';

Future<DataState<DetailEntity>> serializTiktok3(
    Future<dynamic> request, String link) async {
  Response response = await request;
  if (response.statusCode == 200) {
    final json = response.data['data'];
    List<DetailFile> videos = [];
    if (json.containsKey('play')) {
      videos.add(
        DetailFile(
          url: json['play'],
          name: 'tiktok-video-${generateRandomString(16)}',
          type: "mp4",
          size: json.containsKey('size') ? json['size'] : null,
        ),
      );
    }

    List<DetailFile> audios = [];
    if (json.containsKey('music')) {
      audios.add(
        DetailFile(
          url: json['music'],
          name: 'tiktok-audio-${generateRandomString(16)}',
          type: "mp3",
        ),
      );
    }

    DetailCaption? caption;
    if (json.containsKey('title') && json['title'].trim().isNotEmpty) {
      caption = DetailCaption(title: json['title']);
    }

    if (videos.isEmpty && audios.isEmpty && caption == null) {
      return const DataFailed(somthinWorng);
    }

    String? author;
    if (json.containsKey('author') && json['author'].containsKey('unique_id')) {
      author = json['author']['unique_id'];
    }

    String? avatarThumb;
    if (json.containsKey('author') && json['author'].containsKey('avatar')) {
      avatarThumb = await getImageByt(json['author']['avatar']);
    }

    DetailOwner? owner;
    if (author != null || avatarThumb != null) {
      owner = DetailOwner(username: author.toString(), profileUrl: avatarThumb);
    }

    String? thumb;
    if (json.containsKey('origin_cover')) {
      thumb = await getImageByt(json['origin_cover']);
    }

    DetailEntity data = DetailEntity(
      platform: 'tiktok',
      link: link,
      title: author ?? 'tiktok',
      owner: owner,
      thumb: thumb,
      videos: videos == [] ? null : videos,
      audios: audios == [] ? null : audios,
      caption: caption,
    );
    return DataSuccess(data);
  } else {
    return const DataFailed(somthinWorng);
  }
}

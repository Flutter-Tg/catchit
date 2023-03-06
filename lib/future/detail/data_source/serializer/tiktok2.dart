import 'package:catchit/core/helper/error_msg.dart';
import 'package:catchit/core/helper/generate_random_string.dart';
import 'package:catchit/core/helper/save_image.dart';
import 'package:catchit/core/resources/data_state.dart';
import 'package:catchit/future/detail/domain/entity/detail.dart';
import 'package:dio/dio.dart';

Future<DataState<DetailEntity>> serializTiktok2(
    Future<dynamic> request, String link) async {
  Response response = await request;
  if (response.statusCode == 200) {
    final json = response.data['aweme_detail'];
    List<DetailFile> videos = [];
    if (json.containsKey('video') &&
        json['video'].containsKey('download_addr')) {
      videos.add(
        DetailFile(
          url: json['video']['download_addr']['url_list'][0],
          name: 'tiktok-video-${generateRandomString(16)}',
          type: "mp4",
          size: json['video']['download_addr']['data_size'],
        ),
      );
    }

    String? author;
    if (json.containsKey('author') && json['author'].containsKey('ins_id')) {
      author = json['author']["ins_id"];
    }

    String? avatarThumb;
    if (json.containsKey('author') &&
        json['author'].containsKey('avatar_thumb')) {
      avatarThumb =
          await getImageByt(json['author']['avatar_thumb']['url_list'][0]);
    }

    DetailCaption? caption;
    if (json.containsKey('desc') && json['desc'].trim().isNotEmpty) {
      caption = DetailCaption(description: json['desc']);
    }

    DetailOwner? owner;
    if (author != null || avatarThumb != null) {
      owner = DetailOwner(username: author.toString(), profileUrl: avatarThumb);
    }

    String? thumb;
    if (json.containsKey('video') && json['video'].containsKey('cover')) {
      thumb = await getImageByt(json['video']['cover']['url_list'][0]);
    }

    DetailEntity data = DetailEntity(
      platform: 'tiktok',
      link: link,
      title: author ?? 'tiktok',
      owner: owner,
      thumb: thumb,
      videos: videos == [] ? null : videos,
      caption: caption,
    );
    return DataSuccess(data);
  } else {
    return const DataFailed(somthinWorng);
  }
}

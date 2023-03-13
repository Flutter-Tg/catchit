import 'package:catchit/core/helper/error_msg.dart';
import 'package:catchit/core/helper/generate_random_string.dart';
import 'package:catchit/core/helper/get_file_info.dart';
import 'package:catchit/core/helper/save_image.dart';
import 'package:catchit/core/params/file_info.dart';
import 'package:catchit/core/resources/data_state.dart';
import 'package:catchit/future/detail/domain/entity/detail.dart';
import 'package:dio/dio.dart';

Future<DataState<DetailEntity>> serializTiktok1(
    Future<dynamic> request, String link) async {
  Response response = await request;
  if (response.statusCode == 200) {
    GetFileInfo getFileInfo = GetFileInfo();
    final json = response.data;
    List<DetailFile> videos = [];
    if (json.containsKey('video')) {
      for (var video in json['video']) {
        FileInfoParam? info;
        info = await getFileInfo.fileInfo(video);
        info ??= FileInfoParam(format: 'video', type: 'mp4');
        videos.add(
          DetailFile(
            url: video,
            name: 'tiktok-veideo-${generateRandomString(16)}',
            type: info.type,
            size: info.size,
          ),
        );
      }
    }

    List<DetailFile> audios = [];
    if (json.containsKey('music')) {
      for (var audio in json['music']) {
        FileInfoParam? info = await getFileInfo.fileInfo(audio);
        audios.add(
          DetailFile(
            url: audio,
            name: 'tiktok-audio-${generateRandomString(16)}',
            type: 'mp3',
            size: info?.size,
          ),
        );
      }
    }

    DetailCaption? caption;
    if (json.containsKey('description')) {
      caption = DetailCaption(description: json['description'][0]);
    }

    if (videos.isEmpty && audios.isEmpty && caption == null) {
      return const DataFailed(somthinWorng);
    }

    String? author;
    if (json.containsKey('author')) {
      author = json['author'][0];
    }

    String? avatarThumb;
    if (json.containsKey('avatarThumb')) {
      avatarThumb = await getImageByt(json['avatarThumb'][0]);
    }

    DetailOwner? owner;
    if (author != null || avatarThumb != null) {
      owner = DetailOwner(username: author.toString(), profileUrl: avatarThumb);
    }

    String? thumb;
    if (json.containsKey('cover')) {
      thumb = await getImageByt(json['cover'][0]);
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

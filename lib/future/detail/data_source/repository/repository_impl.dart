import 'package:catchit/core/helper/get_file_info.dart';
import 'package:catchit/core/params/file_info.dart';
import 'package:catchit/core/resources/data_state.dart';
import 'package:catchit/future/detail/data_source/local/dao.dart';
import 'package:catchit/future/detail/data_source/remote/api_provider.dart';
import 'package:catchit/future/detail/domain/entity/detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/helper/generate_random_string.dart';
import '../../domain/entity/detail_db.dart';
import '../../domain/repository/repository.dart';

class DetailRepositoryImpl extends DetailRepository {
  DetailDao detailDao;
  DetailApiProvider apiProvider;
  DetailRepositoryImpl(this.detailDao, this.apiProvider);

  GetFileInfo getFileInfo = GetFileInfo();

  @override
  Future<DataState<List<DetailEntity>>> getDbDetails() async {
    try {
      List<DetailDbEntity> detailDbList = await detailDao.getAllDetails();

      List<DetailEntity> details = [];
      for (var detail in detailDbList) {
        DetailEntity detailEntity = DetailEntity.fromDb(detail);
        details.add(detailEntity);
      }

      return DataSuccess(details);
    } catch (e) {
      debugPrint('getDbDetails : error = $e');
      return const DataFailed('error');
    }
  }

  @override
  Future<DataState<dynamic>> addDetailToDb(DetailEntity detailEntity) async {
    try {
      DetailDbEntity detailDb = detailEntity.toDb();
      await detailDao.insertDetail(detailDb);
      return const DataSuccess(null);
    } catch (e) {
      debugPrint('addDetailToDb : error = $e');
      return const DataFailed('error');
    }
  }

  @override
  Future<DataState<dynamic>> deleteDbDetails() async {
    try {
      List<DetailDbEntity> detailDbList = await detailDao.getAllDetails();
      for (var detail in detailDbList) {
        await detailDao.deleteDetailbyId(detail.id as int);
      }
      return const DataSuccess(null);
    } catch (e) {
      debugPrint('deleteDbDetails : error = $e');
      return const DataFailed('error');
    }
  }

  @override
  Future<DataState<dynamic>> deleteDbDetail(int id) async {
    try {
      await detailDao.deleteDetailbyId(id);
      return const DataSuccess(null);
    } catch (e) {
      debugPrint('deleteDbDetail : error = $e');
      return const DataFailed('error');
    }
  }

  @override
  Future<DataState<DetailEntity>> tiktokApi(String link) async {
    try {
      Response response = await apiProvider.tiktok(link);

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
        if (json.containsKey('video')) {
          for (var audio in json['music']) {
            FileInfoParam? info;
            info = await getFileInfo.fileInfo(audio);
            info ??= FileInfoParam(format: 'audio', type: 'mp3');
            audios.add(
              DetailFile(
                url: audio,
                name: 'tiktok-audio-${generateRandomString(16)}',
                type: info.type,
                size: info.size,
              ),
            );
          }
        }

        String? author = json.containsKey('author') ? json['author'][0] : null;
        String? avatarThumb =
            json.containsKey('avatarThumb') ? json['avatarThumb'][0] : null;
        DetailOwner? owner = author != null || avatarThumb != null
            ? DetailOwner(
                username: author.toString(),
                profileUrl: avatarThumb,
              )
            : null;

        String? thumb = json.containsKey('cover')
            ? json['cover'][0]
            : json.containsKey('dynamic_cover')
                ? json['dynamic_cover'][0]
                : null;

        DetailCaption? caption = json.containsKey('description')
            ? DetailCaption(description: json['description'][0])
            : null;

        if (videos.isEmpty && audios.isEmpty && caption == null) {
          return const DataFailed('SomethingWrong');
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
        return const DataFailed('SomethingWrong');
      }
    } catch (e) {
      debugPrint('tiktokApi : error = $e');

      return const DataFailed('ConnectionWorng');
    }
  }

  @override
  Future<DataState<DetailEntity>> instagramApi(String link) async {
    try {
      Response response = await apiProvider.instagram(link);
      if (response.statusCode == 200) {
        GetFileInfo getFileInfo = GetFileInfo();
        Map<String, dynamic> json =
            Map.castFrom<String, dynamic, String, dynamic>(response.data);
        List<DetailFile> videos = [];
        List<DetailFile> images = [];

        if (json.containsKey('media')) {
          if (json['media'] is List) {
            for (var media in json['media']) {
              FileInfoParam? info;
              info = await getFileInfo.fileInfo(media);
              if (info == null) {
                String fromatMedia = '';
                if (media.toString().contains("jpg")) {
                  fromatMedia = 'image';
                } else if (media.toString().contains("mp4")) {
                  fromatMedia = 'video';
                } else {
                  return const DataFailed('SomethingWrong');
                }

                info = FileInfoParam(format: fromatMedia, type: 'jpg');
              }

              if (info.format == 'video') {
                videos.add(
                  DetailFile(
                    url: media,
                    name: 'instagram-video-${generateRandomString(16)}',
                    type: info.type,
                    size: info.size,
                  ),
                );
              } else if (info.format == 'image') {
                images.add(
                  DetailFile(
                    url: media,
                    name: 'instagram-image-${generateRandomString(16)}',
                    type: info.type,
                    size: info.size,
                  ),
                );
              }
            }
          } else {
            String url = json['media'];
            FileInfoParam? info;
            info = await getFileInfo.fileInfo(url);
            if (info == null) {
              String fromatMedia = '';
              if (url.toString().contains("jpg")) {
                fromatMedia = 'image';
              } else if (url.toString().contains("mp4")) {
                fromatMedia = 'video';
              } else {
                return const DataFailed('SomethingWrong');
              }

              info = FileInfoParam(format: fromatMedia, type: 'jpg');
            }

            if (info.format == 'video') {
              videos.add(
                DetailFile(
                  url: url,
                  name: 'instagram-video-${generateRandomString(16)}',
                  type: info.type,
                  size: info.size,
                ),
              );
            } else if (info.format == 'image') {
              images.add(
                DetailFile(
                  url: json['media'],
                  name: 'instagram-image-${generateRandomString(16)}',
                  type: info.type,
                  size: info.size,
                ),
              );
            }
          }
        }

        String? thumb =
            json.containsKey('thumbnail') ? json['thumbnail'] : null;

        if (thumb == null) {
          if (images.isNotEmpty) {
            thumb = images[0].url;
          }
        }
        if (videos.isEmpty &&
            images.isEmpty &&
            json.containsKey('title') == false) {
          return const DataFailed('SomethingWrong');
        }
        DetailEntity data = DetailEntity(
          platform: 'instagram',
          link: link,
          title: 'instagram',
          thumb: thumb,
          videos: videos.isEmpty ? null : videos,
          images: images.isEmpty ? null : images,
          caption: json.containsKey('title')
              ? json['title'] != ''
                  ? DetailCaption(
                      description: json['title'],
                    )
                  : null
              : null,
        );
        return DataSuccess(data);
      } else {
        return const DataFailed('SomethingWrong');
      }
    } catch (e) {
      debugPrint('instagramApi : error = $e');

      return const DataFailed('ConnectionWorng');
    }
  }

  @override
  Future<DataState<DetailEntity>> facebookApi(String link) async {
    try {
      Response response = await apiProvider.facebook(link);
      if (response.statusCode == 200) {
        GetFileInfo getFileInfo = GetFileInfo();
        final json = response.data;
        List<DetailFile> videos = [];
        if (json.containsKey('links')) {
          if (json['links'].containsKey('Download High Quality')) {
            final video = json['links']['Download High Quality'];
            FileInfoParam? info;
            info = await getFileInfo.fileInfo(video);
            info ??= FileInfoParam(format: 'video', type: 'mp4');
            videos.add(
              DetailFile(
                title: "High Quality",
                url: video,
                name: 'facebook-video-${generateRandomString(16)}',
                type: info.type,
                size: info.size,
              ),
            );
          }
          if (videos.isEmpty) {
            if (json['links'].containsKey('Download Low Quality')) {
              final video = json['links']['Download Low Quality'];
              FileInfoParam? info;
              info = await getFileInfo.fileInfo(video);
              info ??= FileInfoParam(format: 'video', type: 'mp4');
              videos.add(
                DetailFile(
                  title: "Low Quality",
                  url: video,
                  name: 'facebook-video-${generateRandomString(16)}',
                  type: info.type,
                  size: info.size,
                ),
              );
            }
          }
        }

        String? thumb =
            json.containsKey('thumbnail') ? json['thumbnail'] : null;

        DetailCaption? caption = json.containsKey('title')
            ? DetailCaption(title: json['title'])
            : null;

        if (videos.isEmpty && caption == null) {
          return const DataFailed('SomethingWrong');
        }

        DetailEntity data = DetailEntity(
          platform: 'facebook',
          link: link,
          title: caption != null ? caption.title.toString() : 'facebook',
          thumb: thumb,
          videos: videos == [] ? null : videos,
          caption: caption,
        );
        return DataSuccess(data);
      } else {
        return const DataFailed('SomethingWrong');
      }
    } catch (e) {
      debugPrint('facebookApi : error = $e');
      return const DataFailed('ConnectionWorng');
    }
  }

  //! youtube
  // @override
  // Future<DataState<DetailEntity>> youtubeApi(String link) async {
  //   try {
  //     Response response =
  //         await apiProvider.youtube(YoutubHelper().parser(link));
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> json =
  //           Map.castFrom<String, dynamic, String, dynamic>(response.data);
  //       String? title = json.containsKey('title') ? json['title'] : null;
  //       String? description =
  //           json.containsKey('description') ? json['description'] : null;
  //       DetailCaption? caption = title != null || description != null
  //           ? DetailCaption(title: title, description: description)
  //           : null;

  //       String? thumb;
  //       if (json.containsKey('thumbnails')) {
  //         thumb = json['thumbnails'][0]['url'];
  //       }

  //       List<DetailFile> videos = [];
  //       if (json.containsKey('videos')) {
  //         for (var video in json['videos']['items']) {
  //           if (video['extension'] == 'mp4' && video['hasAudio'] == true) {
  //             FileInfoParam info = await getFileInfo.fileInfo(video['url']);
  //             String quality = video['quality'].replaceAll(RegExp('p'), '');
  //             videos.add(
  //               DetailFile(
  //                 title: quality,
  //                 url: video['url'],
  //                 name: title != null
  //                     ? '$title-${quality}p'
  //                     : 'vedio-${generateRandomString(16)}-${quality}p',
  //                 quality: quality,
  //                 type: info.type,
  //                 size: info.size,
  //               ),
  //             );
  //           }
  //         }
  //       }

  //       List<DetailFile> audios = [];
  //       if (json.containsKey('audios')) {
  //         for (var audio in json['audios']['items']) {
  //           if (audio['extension'] == 'mp4' ||
  //               audio['extension'] == 'm4p' ||
  //               audio['extension'] == 'm4a' ||
  //               audio['extension'] == 'mp3') {
  //             // FileInfoParam info = await getFileInfo.fileInfo(audio['url']);
  //             audios.add(
  //               DetailFile(
  //                 url: audio['url'],
  //                 name: title ?? 'audio-youtub-${generateRandomString(16)}',
  //                 type: 'mp3',
  //                 size: double.parse(audio['size'].toString()).round(),
  //               ),
  //             );
  //           }
  //         }
  //       }
  //       if (videos.isEmpty && audios.isEmpty && caption == null) {
  //         return const DataFailed('SomethingWrong');
  //       }
  //       DetailEntity data = DetailEntity(
  //         platform: 'youtube',
  //         link: link,
  //         title: title ?? 'youtub',
  //         videos: videos.isEmpty ? null : videos,
  //         audios: audios.isEmpty ? null : audios,
  //         thumb: thumb,
  //         caption: caption,
  //       );
  //       return DataSuccess(data);
  //     } else {
  //       return const DataFailed('SomethingWrong');
  //     }
  //   } catch (e) {
  //     if (kDebugMode) print(e);
  //     return const DataFailed('ConnectionWorng');
  //   }
  // }

  //! spotify
  // @override
  // Future<DataState<DetailEntity>> spotifyApi(String link) async {
  //   try {
  //     Response response = await apiProvider.spotify(link);
  //     if (response.statusCode == 200) {
  //       final jsonData = jsonDecode(response.data);
  //       Map<String, dynamic> json =
  //           Map.castFrom<String, dynamic, String, dynamic>(jsonData);

  //       late DetailEntity data;
  //       if (json.containsKey('tracks')) {
  //         List<DetailFile> audios = [];
  //         for (var audio in json['tracks']) {
  //           final audioDetailFormUrl =
  //               audio['audio']['url'].toString().split('/');
  //           audios.add(
  //             DetailFile(
  //               title: audio.containsKey('name') ? audio['name'] : null,
  //               url: audio['audio']['url'],
  //               name: audio['name'] != null
  //                   ? '${audio['name']}'
  //                   : 'spotify-${generateRandomString(16)}',
  //               type: audioDetailFormUrl[7],
  //               size: double.parse(audio['audio']['size'].toString()).round(),
  //               quality: audioDetailFormUrl[8],
  //             ),
  //           );
  //         }
  //         String? albumName = json.containsKey('name') ? json['name'] : null;
  //         data = DetailEntity(
  //           platform: 'spotify',
  //           link: link,
  //           title: albumName ?? 'spotify',
  //           audios: audios == [] ? null : audios,
  //           caption: json.containsKey('name')
  //               ? DetailCaption(description: "Album : albumName")
  //               : null,
  //         );
  //       } else {
  //         final audioDetailFormUrl = json['audio']['url'].toString().split('/');

  //         DetailFile audio = DetailFile(
  //           url: json['audio']['url'],
  //           name: json['name'] != null
  //               ? '${json['name']}'
  //               : 'spotify-${generateRandomString(16)}',
  //           type: audioDetailFormUrl[7],
  //           size: double.parse(json['audio']['size'].toString()).round(),
  //           quality: audioDetailFormUrl[8],
  //         );
  //         String? thumb = json.containsKey('album')
  //             ? json['album'].containsKey('cover')
  //                 ? json['album']['cover']
  //                 : null
  //             : null;

  //         String? songName = json.containsKey('name') ? json['name'] : null;

  //         String? name =
  //             json.containsKey('name') ? "Name: ${json['name']}\n" : '';
  //         String? albumName = json.containsKey('album')
  //             ? json['album'].containsKey('name')
  //                 ? "Album: ${json['album']['name']}\n"
  //                 : ''
  //             : '';
  //         String? artists =
  //             json.containsKey('artists') ? "Artists: ${json['artists']}" : '';

  //         String description = name + albumName + artists;

  //         data = DetailEntity(
  //           platform: 'spotify',
  //           link: link,
  //           title: songName ?? 'spotify',
  //           thumb: thumb,
  //           audios: [audio],
  //           caption: description.isNotEmpty
  //               ? DetailCaption(description: description)
  //               : null,
  //         );
  //       }

  //       return DataSuccess(data);
  //     } else {
  //       return const DataFailed('SomethingWrong');
  //     }
  //   } catch (e) {
  //     if (kDebugMode) print(e);
  //     return const DataFailed('ConnectionWorng');
  //   }
  // }

}

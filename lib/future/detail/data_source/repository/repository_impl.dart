import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/helper/error_msg.dart';
import 'package:catchit/core/helper/get_file_info.dart';
import 'package:catchit/core/helper/save_image.dart';
import 'package:catchit/core/params/file_info.dart';
import 'package:catchit/core/resources/data_state.dart';
import 'package:catchit/core/services/internet.dart';
import 'package:catchit/future/detail/data_source/remote/api_provider.dart';
import 'package:catchit/future/detail/data_source/serializer/tiktok1.dart';
import 'package:catchit/future/detail/data_source/serializer/tiktok2.dart';
import 'package:catchit/future/detail/data_source/serializer/tiktok3.dart';
import 'package:catchit/future/detail/data_source/serializer/tiktok4.dart';
import 'package:catchit/future/detail/data_source/serializer/tiktok5.dart';
import 'package:catchit/future/detail/domain/entity/detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:catchit/core/helper/generate_random_string.dart';
import 'package:catchit/future/detail/domain/repository/repository.dart';

class DetailRepositoryImpl extends DetailRepository {
  DetailApiProvider apiProvider;
  DetailRepositoryImpl(this.apiProvider);
  GetFileInfo getFileInfo = GetFileInfo();
  @override
  Future<DataState<DetailEntity>> tiktokApi(String link) async {
    if (await InternetService().checkConncetivity()) {
      try {
        if (ApiConfig.tiktok1) {
          return await serializTiktok1(apiProvider.tiktok(link), link);
        } else if (ApiConfig.tiktok2) {
          return await serializTiktok2(apiProvider.tiktok2(link), link);
        } else if (ApiConfig.tiktok3) {
          return await serializTiktok3(apiProvider.tiktok3(link), link);
        } else if (ApiConfig.tiktok4) {
          return await serializTiktok4(apiProvider.tiktok4(link), link);
        } else if (ApiConfig.tiktok5) {
          return await serializTiktok5(apiProvider.tiktok5(link), link);
        } else {
          return const DataFailed(somthinWorng);
        }
      } catch (e) {
        debugPrint('tiktokApi : error = $e');
        return const DataFailed(somthinWorng);
      }
    } else {
      return const DataFailed(networkError);
    }
  }

  @override
  Future<DataState<DetailEntity>> instagramApi(String link) async {
    if (await InternetService().checkConncetivity()) {
      try {
        if (ApiConfig.instagram1) {
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
                      return const DataFailed(somthinWorng);
                    }

                    info = FileInfoParam(format: fromatMedia, type: 'jpg');
                  }

                  if (info.format == 'video') {
                    videos.add(
                      DetailFile(
                        url: media,
                        name: 'instagram1-video-${generateRandomString(16)}',
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
                    return const DataFailed(somthinWorng);
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
                thumb = await getImageByt(images[0].url);
              }
            } else {
              thumb = await getImageByt(thumb);
            }

            if (videos.isEmpty &&
                images.isEmpty &&
                json.containsKey('title') == false) {
              return const DataFailed(somthinWorng);
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
          }
        }
        return const DataFailed(somthinWorng);
      } catch (e) {
        debugPrint('instagramApi : error = $e');
        if (e.toString().contains("502")) {
          return const DataFailed(privatePage);
        }
        return const DataFailed(somthinWorng);
      }
    } else {
      return const DataFailed(networkError);
    }
  }

  @override
  Future<DataState<DetailEntity>> facebookApi(String link) async {
    if (await InternetService().checkConncetivity()) {
      try {
        if (ApiConfig.facebook1) {
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

            String? thumb = json.containsKey('thumbnail')
                ? await getImageByt(json['thumbnail'])
                : null;

            DetailCaption? caption = json.containsKey('title')
                ? DetailCaption(title: json['title'])
                : null;

            if (videos.isEmpty && caption == null) {
              return const DataFailed(somthinWorng);
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
          }
        }
        return const DataFailed(somthinWorng);
      } catch (e) {
        debugPrint('facebookApi : error = $e');
        return const DataFailed(somthinWorng);
      }
    } else {
      return const DataFailed(networkError);
    }
  }
}

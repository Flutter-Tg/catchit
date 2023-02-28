import 'package:catchit/core/utils/consts/path_constants.dart';
import 'package:dio/dio.dart';

class DetailApiProvider {
  Dio dio = Dio();

  Future<dynamic> tiktok(String link) async {
    final response = await dio.get(
      'https://tiktok-downloader-download-tiktok-videos-without-watermark.p.rapidapi.com/vid/index',
      queryParameters: {'url': link},
      options: Options(
        headers: {
          'X-RapidAPI-Key': PathConstants.rapidApiKey,
          'X-RapidAPI-Host':
              'tiktok-downloader-download-tiktok-videos-without-watermark.p.rapidapi.com'
        },
      ),
    );
    return response;
  }

  Future<dynamic> instagram(String link) async {
    final response = await dio.get(
      'https://instagram-downloader-download-instagram-videos-stories.p.rapidapi.com/index',
      queryParameters: {'url': link},
      options: Options(
        headers: {
          'X-RapidAPI-Key': PathConstants.rapidApiKey,
          'X-RapidAPI-Host':
              'instagram-downloader-download-instagram-videos-stories.p.rapidapi.com'
        },
      ),
    );
    return response;
  }

  Future<dynamic> facebook(String link) async {
    final response = await dio.get(
      'https://facebook-reel-and-video-downloader.p.rapidapi.com/app/main.php',
      queryParameters: {'url': link},
      options: Options(
        headers: {
          'X-RapidAPI-Key': PathConstants.rapidApiKey,
          'X-RapidAPI-Host': 'facebook-reel-and-video-downloader.p.rapidapi.com'
        },
      ),
    );
    return response;
  }

  //! youtube
  // Future<dynamic> youtube(String link) async {
  //   final response = await dio.get(
  //     'https://youtube-media-downloader.p.rapidapi.com/v2/video/details',
  //     queryParameters: {'videoId': link},
  //     options: Options(
  //       headers: {
  //         'X-RapidAPI-Key': PathConstants.rapidApiKey,
  //         'X-RapidAPI-Host': 'youtube-media-downloader.p.rapidapi.com'
  //       },
  //     ),
  //   );
  //   return response;
  // }

  //! spotify
  // Future<dynamic> spotify(String link) async {
  //   final response = await dio.get(
  //     'https://spotify-downloader.p.rapidapi.com/SpotifyDownloader',
  //     queryParameters: {'url': link},
  //     options: Options(
  //       headers: {
  //         'X-RapidAPI-Key': PathConstants.rapidApiKey,
  //         'X-RapidAPI-Host': 'spotify-downloader.p.rapidapi.com'
  //       },
  //     ),
  //   );
  //   return response;
  // }
}

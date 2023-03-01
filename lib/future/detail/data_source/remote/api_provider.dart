import 'package:catchit/config/app_config.dart';
import 'package:dio/dio.dart';

class DetailApiProvider {
  Dio dio = Dio();

  Future<dynamic> tiktok(String link) async {
    final response = await dio.get(
      'https://tiktok-downloader-download-tiktok-videos-without-watermark.p.rapidapi.com/vid/index',
      queryParameters: {'url': link},
      options: Options(
        headers: {
          'X-RapidAPI-Key': AppConfig.rapidApiKey,
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
          'X-RapidAPI-Key': AppConfig.rapidApiKey,
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
          'X-RapidAPI-Key': AppConfig.rapidApiKey,
          'X-RapidAPI-Host': 'facebook-reel-and-video-downloader.p.rapidapi.com'
        },
      ),
    );
    return response;
  }
}

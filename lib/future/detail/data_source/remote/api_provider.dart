import 'package:catchit/config/app_config.dart';
import 'package:dio/dio.dart';

class DetailApiProvider {
  Dio dio = Dio();

  Future<dynamic> instagram(String link) async {
    // Instagram Downloader - Download Instagram Videos - Stories
    // https://rapidapi.com/maatootz/api/instagram-downloader-download-instagram-videos-stories/
    final response = await dio.get(
      'https://instagram-downloader-download-instagram-videos-stories.p.rapidapi.com/index',
      queryParameters: {'url': link},
      options: Options(
        headers: {
          'X-RapidAPI-Key':
              "3eaa23ef94msh247217ad673c836p195bb3jsn6ce4fd1ad4a5", // AppConfig.rapidApiKey,
          'X-RapidAPI-Host':
              'instagram-downloader-download-instagram-videos-stories.p.rapidapi.com'
        },
      ),
    );
    return response;
  }

  Future<dynamic> facebook(String link) async {
    // Facebook Reel and Video Downloader
    // https://rapidapi.com/vikas5914/api/facebook-reel-and-video-downloader/
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

  Future<dynamic> tiktok(String link) async {
    // TikTok Downloader - Download TikTok Videos without watermark
    // https://rapidapi.com/maatootz/api/tiktok-downloader-download-tiktok-videos-without-watermark
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

  Future<dynamic> tiktok2(String link) async {
    // TokApi - mobile version
    // https://rapidapi.com/Sonjik/api/tokapi-mobile-version/
    final response = await dio.get(
      'https://tokapi-mobile-version.p.rapidapi.com/v1/post',
      queryParameters: {'video_url': link},
      options: Options(
        headers: {
          'X-RapidAPI-Key': AppConfig.rapidApiKey,
          'X-RapidAPI-Host': 'tokapi-mobile-version.p.rapidapi.com'
        },
      ),
    );
    return response;
  }

  Future<dynamic> tiktok3(String link) async {
    // Tiktok Download Without Watermark
    // https://rapidapi.com/yi005/api/tiktok-download-without-watermark/
    final response = await dio.get(
      'https://tiktok-download-without-watermark.p.rapidapi.com/analysis',
      queryParameters: {'url': link, "hd": "0"},
      options: Options(
        headers: {
          'X-RapidAPI-Key': AppConfig.rapidApiKey,
          'X-RapidAPI-Host': 'tiktok-download-without-watermark.p.rapidapi.com'
        },
      ),
    );
    return response;
  }

  Future<dynamic> tiktok4(String link) async {
    // Tiktok video no watermark
    // https://rapidapi.com/yi005/api/tiktok-video-no-watermark2/
    final response = await dio.get(
      'https://tiktok-video-no-watermark2.p.rapidapi.com/',
      queryParameters: {'url': link, "hd": "0"},
      options: Options(
        headers: {
          'X-RapidAPI-Key': AppConfig.rapidApiKey,
          'X-RapidAPI-Host': 'tiktok-video-no-watermark2.p.rapidapi.com'
        },
      ),
    );
    return response;
  }

  Future<dynamic> tiktok5(String link) async {
    // Tiktok full info without watermark
    // https://rapidapi.com/maatootz/api/tiktok-full-info-without-watermark/
    final response = await dio.get(
      'https://tiktok-full-info-without-watermark.p.rapidapi.com/vid/index',
      queryParameters: {'url': link},
      options: Options(
        headers: {
          'X-RapidAPI-Key': AppConfig.rapidApiKey,
          'X-RapidAPI-Host': 'tiktok-full-info-without-watermark.p.rapidapi.com'
        },
      ),
    );
    return response;
  }
}

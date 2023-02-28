class YoutubHelper {
  String parser(String link) {
    // watch?v=HYsz1hP0BFo&feature=share
    String youtubId = link.split('/')[3];
    if (youtubId.contains('v=')) {
      youtubId = youtubId.split('v=')[1];
    }
    if (youtubId.contains('&')) {
      youtubId = youtubId.split('&')[0];
    }
    return youtubId;
  }
}

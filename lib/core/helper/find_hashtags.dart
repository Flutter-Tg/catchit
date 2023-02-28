List<String> findHashtags(String text) {
  List<String> hashtags = [];
  var re = RegExp(r'(?<=#)(.*)(?=' '|#)');
  List<String> list = text.split(' ');
  for (var tags in list) {
    var match = re.firstMatch(tags);
    if (match != null) {
      String tag = match.group(0).toString();
      if (tag.contains('#')) {
        List<String> special = tag.split('#');
        for (var element in special) {
          hashtags.add(element.trim());
        }
      } else {
        hashtags.add(tag.trim());
      }
    }
  }
  return hashtags;
}

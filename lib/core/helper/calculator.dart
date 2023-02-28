class Calculator {
  String byte(int byt) {
    String result = byt.toString();
    if (byt < 1000) {
      return "$result B";
    } else if (byt < 1000000) {
      result = (byt / 1000).toStringAsFixed(1);
      return "$result Kb";
    } else if (byt < 1000000000) {
      result = (byt / 1000000).toStringAsFixed(1);
      return "$result Mb";
    } else if (byt < 1000000000000) {
      result = (byt / 1000000000).toStringAsFixed(1);
      return "$result Gb";
    } else {
      result = (byt / 1000000000000).toStringAsFixed(1);
      return "$result Tb";
    }
  }

  String difference(DateTime from, DateTime to) {
    Duration diff = to.difference(from);
    int inDay = (diff.inDays % 365).round();
    int inHours = (diff.inHours % 24).round();
    int inMinutes = (diff.inMinutes % 60).round();
    int inSecound = (diff.inSeconds % 60).round();
    String day = inDay == 0 ? '' : '${inDay}d ';
    String hours = inHours == 0 ? '' : '${inHours}h ';
    String minutes = inMinutes == 0 ? '' : '${inMinutes}m';
    String secound = inSecound == 0 || minutes != '' ? '' : '${inSecound}s';
    if (inDay != 0) {
      return day + hours;
    } else {
      return hours + minutes + secound;
    }
  }
}

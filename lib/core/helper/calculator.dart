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
}

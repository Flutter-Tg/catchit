import 'package:connectivity_plus/connectivity_plus.dart';

class InternetService {
  Future<bool> checkConncetivity() async {
    var connectivityResult = await Connectivity()
        .checkConnectivity()
        .timeout(const Duration(seconds: 10));
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.vpn) {
      return true;
    } else {
      return false;
    }
  }
}

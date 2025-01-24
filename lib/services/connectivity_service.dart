import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static Future<bool> isOnline() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static Stream<ConnectivityResult> get connectivityStream => Connectivity()
          .onConnectivityChanged
          .map((List<ConnectivityResult> results) {
        return results.first;
      });
}

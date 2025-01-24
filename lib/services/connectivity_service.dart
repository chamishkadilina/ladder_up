import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static Future<bool> isOnline() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Updated to handle List<ConnectivityResult>
  static Stream<ConnectivityResult> get connectivityStream => Connectivity()
          .onConnectivityChanged
          .map((List<ConnectivityResult> results) {
        // The list is never empty according to the package documentation
        // If there's no connectivity, the list contains a single ConnectivityResult.none
        return results.first;
      });
}

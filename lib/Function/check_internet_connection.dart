import 'package:connectivity/connectivity.dart';

class InternetConnection {
  ConnectivityResult connectivityResult;

  Future<bool> checkInternetConnection() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
  }
}

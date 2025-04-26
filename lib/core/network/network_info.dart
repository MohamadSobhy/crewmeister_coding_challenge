import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class AppNetworkInfo extends NetworkInfo {
  @override
  Future<bool> get isConnected {
    if (kIsWeb) {
      return _isDeviceConnectedToInternetWeb();
    } else {
      return _isDeviceConnectedToInternetMobile();
    }
  }

  Future<bool> _isDeviceConnectedToInternetWeb() async {
    try {
      final result = await http.get(Uri.parse('www.google.com'));

      if (result.statusCode == 200) {
        //* Device is not connected to internet [√]
        return true;
      }
    } on SocketException catch (_) {
      //! Device is not connected to internet [x]
    }

    //! Device is not connected to internet [x]
    return false;
  }

  Future<bool> _isDeviceConnectedToInternetMobile() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        //* Device is not connected to internet [√]
        return true;
      }
    } on SocketException catch (_) {
      //! Device is not connected to internet [x]
    }

    //! Device is not connected to internet [x]
    return false;
  }
}

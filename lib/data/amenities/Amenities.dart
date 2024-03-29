import 'dart:io';
import 'package:flutter/foundation.dart';

class Amenities 
    with ChangeNotifier, DiagnosticableTreeMixin {
  Future connectivityChecker(context) async {
    try {
      final result = await InternetAddress.lookup('samil.in');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (err) {
      print('not connected');
      throw err;
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  @override
  Future versionNotify() {
    throw UnimplementedError();
  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:q2smart/res/AppContextExtension.dart';
import '../view/flutter_flow/flutter_flow_theme.dart';
import 'BaseUtilits.dart';

class Utils extends BaseUtilits {
  // static double setAverageRating(List<int> ratings) {
  //   var avgRating = 0;
  //   for (int i = 0; i < ratings.length; i++) {
  //     avgRating = avgRating + ratings[i];
  //   }
  //   return double.parse((avgRating / ratings.length).toStringAsFixed(1));
  // }
  Widget commmonIOSAlert(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        children: <Widget>[
          Text("CupertinoAlertDialog"),
          Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ],
      ),
      content: new Text("An iOS-style alert dialog." +
          "An alert dialog informs the user about situations that require acknowledgement."
              " An alert dialog has an optional title, optional content, and an optional list of actions."),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text("CANCEL"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  String validateMobile(String value) {
    String patttern = r'[6-9]{1}[0-9]{9}';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return "";
  }

  encryptionAESCryptoJS(BuildContext context, String plainText) {
    try {
      var encryptedKey = context.resources.strings.kEncryKey;
      final key = encrypt.Key.fromUtf8(encryptedKey);
      final iv = encrypt.IV.fromUtf8(encryptedKey);
      final encrypter = encrypt.Encrypter(
          encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64;
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget spikeLoader(BuildContext context) {
    return SpinKitThreeBounce(
      color: FlutterFlowTheme.of(context).primaryColor,
      size: 30,
    );
  }

  @override
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> bottomToast(BuildContext context, {required String message}) {
     return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
   
  }
  
}

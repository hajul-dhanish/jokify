import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jokify/res/AppContextExtension.dart';
import '../view/plugin/flutter_flow_theme.dart';
import 'BaseUtilits.dart';

class Utils extends BaseUtilits {

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
  
}

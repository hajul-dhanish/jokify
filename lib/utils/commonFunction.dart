import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:q2smart/utils/Utils.dart';
import 'package:q2smart/view/auth/AuthAlert.dart';
import 'package:q2smart/view/flutter_flow/flutter_flow_util.dart';
import '../view_model/cart/CartItemVM.dart';
import '../view_model/auth/LoginVM.dart';

class CommonFunction {
  updateCart(BuildContext context) async {
    CartItemVM cartItemVM = CartItemVM();
    return await cartItemVM
        .isAvailableLocalCart(context)
        .then((isCartAvl) async {
      if (isCartAvl) {
        await Provider.of<CartItemVM>(context, listen: false)
            .addCartItems(context)
            .then((value) {
          context.go("/");
          
        });
      } else {
        context.go("/");
      }
    });
  }

  // ------------
  Future sendOTP(BuildContext context,
      {required String userID,
      required String email,
      required String name,
      required String pass,
      required String phone,
      String gender = ""}) async {
    final _loginEnc = Utils().encryptionAESCryptoJS(context, userID.trim());
    final _phoneEnc = Utils().encryptionAESCryptoJS(context, phone.trim());
    final _emailEnc = Utils().encryptionAESCryptoJS(context, email.trim());
    final _passEnc = Utils().encryptionAESCryptoJS(context, pass.trim());
    return Provider.of<LoginVM>(context, listen: false)
        .SigninSendOTP(
      phone: _phoneEnc,
      name: name,
      email: _emailEnc,
      password: _passEnc,
      gender: gender,
      userId: _loginEnc,
    ).then(
      (value) {
        if (Provider.of<LoginVM>(context, listen: false).signUpModel.status ==
            "Success") {
          AuthAlert().OtpAlert(context, {
            "gender": gender,
            "name": name,
            "email": email,
            "password": pass,
            "userID": userID,
            "phone": phone,
            "captcha": "",
          });
          // context.pushNamed(
          //   "otpAlert",
          //   queryParams: {
          //     'sendOTPData': serializeParam(
          //       {
          //         "action": "Signupdetails",
          //         "gender": gender,
          //         "name": name,
          //         "email": _emailEnc,
          //         "password": _passEnc,
          //         "userID": _loginEnc,
          //         "phone": _phoneEnc,
          //         "captcha": "",
          //       },
          //       ParamType.JSON,
          //     ),
          //   }.withoutNulls,
          // );
        } else {
          Utils().bottomToast(context, message: 'Signup failed');
        }
      },
    );
  }
  // -------------------------

// --------------------
  bool isEmail(String input) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(input);
// --------------------
  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4}$')
          .hasMatch(input);
// --------------------
  bool passValidate(String input) => RegExp(
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
      .hasMatch(input);
// --------------------
}

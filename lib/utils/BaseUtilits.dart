import 'package:flutter/material.dart';

abstract class BaseUtilits {
  Widget commmonIOSAlert(BuildContext context);
  Widget spikeLoader(BuildContext context);
   ScaffoldFeatureController<SnackBar, SnackBarClosedReason> bottomToast(BuildContext context, {required String message});
  
}

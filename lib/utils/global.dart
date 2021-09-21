import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product_hunt_app/utils/app_colors.dart';
import 'package:product_hunt_app/utils/app_enums.dart';
import 'package:product_hunt_app/utils/app_style.dart';

// set environment for application
const BuildType appBuildType = BuildType.uat;

printDebug(Object object) {
  if (kDebugMode) {
    print(object ?? '');
  }
}

// Circular Progress Indicator.
loadingIndicator({double size}) {
  return SizedBox(
    height: size ?? 30,
    width: size ?? 30,
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.blue),
      strokeWidth: 4,
    ),
  );
}

// Checking wheather value is null or empty.
bool isNullOrEmpty(dynamic value) {
  if (value == null) {
    return true;
  } else {
    if (value is List || value is String) {
      return value.isEmpty;
    } else {
      return value == '';
    }
  }
}

showSnackBar(
    {@required String message,
    @required BuildContext context,
    bool isSuccess = false,
    int duration}) {
  SnackBar snackBar = SnackBar(
    content: Text(
      message,
      style: AppStyle.whiteBold14,
    ),
    backgroundColor: isSuccess ? AppColors.green : AppColors.red,
    duration: Duration(seconds: duration ?? 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  printDebug(message);
}

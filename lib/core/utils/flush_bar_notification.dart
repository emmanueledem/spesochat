import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spesochat/core/constants/app_assets.dart';
import 'package:spesochat/core/constants/colors.dart';

class FlushBarNotification {
  static Future<void> showError({
    required BuildContext context,
    required String message,
  }) {
    // ignore: inference_failure_on_instance_creation
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: AppColors.kDanger,
      borderRadius: BorderRadius.circular(7),
      icon: SvgPicture.asset(
        AppAssets.close,
      ),
    ).show(context);
  }

  static Future<void> showSuccess({
    required BuildContext context,
    required String message,
  }) {
    // ignore: inference_failure_on_instance_creation
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      message: message,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.green,
      borderRadius: BorderRadius.circular(7),
      icon: SvgPicture.asset(
        AppAssets.tickGood,
      ),
    ).show(context);
  }

  static dynamic showInfoMessage({
    required BuildContext context,
    required String message,
    String title = '',
  }) {
    FlushbarHelper.createInformation(
      message: message,
      title: title,
    ).show(context);
  }
}

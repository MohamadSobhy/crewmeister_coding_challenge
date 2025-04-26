import 'package:flutter/material.dart';

import '../../../app_module.dart';
import '../../enums/app_toast_mode.dart';

class AppToastData {
  final String message;
  final String? actionText;
  final Function()? onActionTapped;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final AppToastMode mode;
  final Duration duration;
  final bool neverExpire;

  AppToastData({
    required this.message,
    this.actionText,
    this.onActionTapped,
    this.padding,
    this.margin,
    this.mode = AppToastMode.info,
    this.duration = const Duration(seconds: 4),
    this.neverExpire = false,
  });
}

class AppToast {
  static final AppToast _instance = AppToast._();

  static AppToast get I => _instance;

  AppToast._();

  void showToast(
    String message, {
    AppToastMode mode = AppToastMode.success,
    bool neverExpire = false,
    String? closeText,
  }) {
    AppModule.I.toastController.sink.add(
      AppToastData(
        message: message,
        mode: mode,
        actionText: closeText,
        neverExpire: neverExpire,
      ),
    );
  }
}

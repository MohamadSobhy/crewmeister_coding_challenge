import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app_module.dart';
import '../../enums/app_toast_mode.dart';
import '../../theme/app_dimensions.dart';
import 'app_toast.dart';

class AppToastView extends StatefulWidget {
  final AppToastData toast;

  const AppToastView({super.key, required this.toast});

  @override
  State<AppToastView> createState() => _AppToastViewState();
}

class _AppToastViewState extends State<AppToastView>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _animation;
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    if (!widget.toast.neverExpire) {
      Future.delayed(widget.toast.duration, () {
        if (mounted && _controller.isCompleted) _hideToast();
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppModule.I.defaultTheme,
      child: FadeTransition(
        opacity: _animation,
        child: Container(
          padding: widget.toast.padding ??
              const EdgeInsets.symmetric(
                horizontal: AppDimensions.dimen_20,
                vertical: AppDimensions.dimen_5,
              ),
          margin: widget.toast.margin ??
              const EdgeInsets.symmetric(
                horizontal: AppDimensions.dimen_20,
                vertical: AppDimensions.dimen_10,
              ),
          // constraints: const BoxConstraints(maxHeight: 150),
          decoration: BoxDecoration(
            color: _getAppropriateToastBGColor(),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                color: AppModule.I.appColors.primaryColor.withOpacity(0.1),
                blurRadius: AppDimensions.radius_15,
                spreadRadius: -10,
              )
            ],
          ),
          child: Row(
            children: [
              Icon(
                _getAppropriateModelIcon(widget.toast.mode),
                color: _getAppropriateModelColor(widget.toast.mode),
              ),
              const SizedBox(width: AppDimensions.defaultSidePadding),
              Expanded(
                child: Text(
                  widget.toast.message,
                  style: AppModule.I.appStyles
                      .text3(color: _getAppropriateTextColor)
                      .copyWith(fontSize: AppFontSizes.font_14),
                ),
              ),
              const SizedBox(
                height: AppDimensions.dimen_30,
                child: VerticalDivider(thickness: 1),
              ),
              TextButton(
                onPressed: widget.toast.onActionTapped ?? _hideToast,
                child: Text(
                  widget.toast.actionText ?? 'Close',
                  style: AppModule.I.appStyles
                      .text3(color: _getAppropriateCloseTextColor),
                  // .copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color? get _getAppropriateTextColor {
    switch (widget.toast.mode) {
      case AppToastMode.success:
      case AppToastMode.error:
        return AppModule.I.appColors.white;

      default:
        return null;
    }
  }

  Color get _getAppropriateCloseTextColor {
    switch (widget.toast.mode) {
      case AppToastMode.success:
      case AppToastMode.error:
        return AppModule.I.appColors.white;
      default:
        return AppModule.I.appColors.lightGrey;
    }
  }

  Color _getAppropriateToastBGColor() {
    switch (widget.toast.mode) {
      case AppToastMode.success:
        return AppModule.I.appColors.validColor;
      case AppToastMode.error:
        return AppModule.I.appColors.errorColor;
      default:
        return AppModule.I.appColors.white;
    }
  }

  void _hideToast() {
    _controller.reverse();

    Future.delayed(const Duration(milliseconds: 500), () {
      AppModule.I.toastController.sink.add(AppToastData(message: ''));
    });
  }

  Color _getAppropriateModelColor(AppToastMode mode) {
    switch (mode) {
      case AppToastMode.info:
        return AppModule.I.appColors.primaryColor;
      case AppToastMode.success:
      // return Colors.green;
      case AppToastMode.error:
        return AppModule.I.appColors.white;
    }
  }

  IconData _getAppropriateModelIcon(AppToastMode mode) {
    switch (mode) {
      case AppToastMode.info:
        return Icons.info_outline_rounded;
      case AppToastMode.success:
        return Icons.check_circle_outline;
      case AppToastMode.error:
        return Icons.error_outline;
      // ignore: unreachable_switch_default
      default:
        return Icons.check_circle_outline;
    }
  }
}

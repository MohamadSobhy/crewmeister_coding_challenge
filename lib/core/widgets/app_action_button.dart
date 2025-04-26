import 'package:crewmeister_coding_challenge/core/widgets/tap_effect.dart';
import 'package:flutter/material.dart';

import '../../app_module.dart';
import '../theme/app_dimensions.dart';
import '../theme/providers/app_themes_provider.dart';
import '../theme/themes.dart';

// ignore: must_be_immutable
class AppActionButton extends StatefulWidget {
  final String text;
  final Color? backgroundColor;
  final bool showLoading;
  final bool? withBorder;
  TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final VoidCallback? onPressed;
  final bool? enableGradient;
  final bool? fitsFullWidth;
  final Widget? leadingIcon;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? actionTextColor;
  final TextDecoration? actionTextDecoration;
  final FontWeight? actionTextWeight;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final Color? borderColor;
  final Color? splashColor;
  final double? actionTextSize;
  final Color? loaderColor;
  final Gradient? backgroundGradient;
  final bool dependOnFieldController;
  final List<TextEditingController>? fieldControllers;
  final bool Function()? enableWhen;
  final String? loadingText;
  final Color? disabledColor;
  final double? leadingSpacing;
  final double? trailingSpacing;
  final Widget? trailingIcon;

  AppActionButton({
    super.key,
    required this.text,
    this.backgroundColor,
    this.loaderColor,
    this.showLoading = false,
    this.withBorder,
    this.textStyle,
    this.borderRadius,
    this.onPressed,
    this.enableGradient,
    this.fitsFullWidth,
    this.leadingIcon,
    this.padding,
    this.margin,
    this.actionTextColor,
    this.actionTextDecoration,
    this.actionTextWeight,
    this.width,
    this.height,
    this.boxShadow,
    this.borderColor,
    this.splashColor,
    this.actionTextSize,
    this.backgroundGradient,
    this.dependOnFieldController = false,
    this.fieldControllers,
    this.enableWhen,
    this.loadingText,
    this.disabledColor,
    this.leadingSpacing,
    this.trailingSpacing,
    this.trailingIcon,
  }) : assert(width == null || width > 0, 'Width can\'t be negative.');

  AppActionButton.submit({
    super.key,
    required this.text,
    Color? backgroundColor,
    Color? actionTextColor,
    this.showLoading = false,
    this.onPressed,
    this.enableGradient,
    this.borderRadius,
    this.fitsFullWidth,
    this.withBorder,
    this.leadingIcon,
    this.loaderColor,
    this.padding,
    this.margin,
    this.textStyle,
    this.actionTextDecoration,
    this.actionTextWeight,
    this.width,
    this.height,
    this.boxShadow,
    this.borderColor,
    this.splashColor,
    this.actionTextSize,
    this.backgroundGradient,
    this.dependOnFieldController = false,
    this.fieldControllers,
    this.enableWhen,
    this.loadingText,
    this.disabledColor,
    this.leadingSpacing,
    this.trailingSpacing,
    this.trailingIcon,
  })  : backgroundColor = backgroundColor ?? AppModule.I.appColors.primaryColor,
        actionTextColor = actionTextColor ?? AppModule.I.appColors.white;

  AppActionButton.submitWithBorder({
    super.key,
    required this.text,
    Color? backgroundColor,
    Color? loaderColor,
    this.showLoading = false,
    this.onPressed,
    this.borderRadius,
    this.fitsFullWidth = true,
    this.leadingIcon,
    this.padding,
    this.margin,
    this.textStyle,
    this.actionTextColor,
    this.actionTextDecoration,
    this.actionTextWeight,
    this.width,
    this.height,
    this.boxShadow,
    this.borderColor,
    this.splashColor,
    this.actionTextSize,
    this.backgroundGradient,
    this.dependOnFieldController = false,
    this.fieldControllers,
    this.enableWhen,
    this.loadingText,
    this.disabledColor,
    this.leadingSpacing,
    this.trailingSpacing,
    this.trailingIcon,
  })  : backgroundColor = backgroundColor ?? AppModule.I.appColors.transparent,
        loaderColor = loaderColor ?? AppModule.I.appColors.white,
        withBorder = true,
        enableGradient = false;

  @override
  State<AppActionButton> createState() => _AppActionButtonState();
}

class _AppActionButtonState extends State<AppActionButton> {
  bool _isEnabled = true;

  @override
  void initState() {
    super.initState();
    if (widget.dependOnFieldController) {
      _isEnabled = _getCurrentEnableStatus();

      if (widget.fieldControllers != null &&
          widget.fieldControllers!.isNotEmpty) {
        for (final controller in widget.fieldControllers!) {
          controller.addListener(_onFieldTextChanged);
        }
      }
    }
  }

  @override
  void didUpdateWidget(covariant AppActionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.fieldControllers != oldWidget.fieldControllers) {
      _updateFieldControllers(oldWidget.fieldControllers);
    }
  }

  void _updateFieldControllers(List<TextEditingController>? oldControllers) {
    // Remove listeners from old controllers
    if (oldControllers != null) {
      for (final controller in oldControllers) {
        controller.removeListener(_onFieldTextChanged);
      }
    }

    // Add listeners to new controllers
    if (widget.fieldControllers != null) {
      for (final controller in widget.fieldControllers!) {
        controller.addListener(_onFieldTextChanged);
      }
    }

    // Update the enabled status
    final status = _getCurrentEnableStatus();
    if (status != _isEnabled) {
      setState(() {
        _isEnabled = status;
      });
    }
  }

  @override
  void dispose() {
    if (widget.dependOnFieldController) {
      if (widget.fieldControllers != null &&
          widget.fieldControllers!.isNotEmpty) {
        for (final controller in widget.fieldControllers!) {
          controller.removeListener(_onFieldTextChanged);
        }
      }
    }

    super.dispose();
  }

  void _onFieldTextChanged() {
    final status = _getCurrentEnableStatus();

    if (status != _isEnabled) {
      setState(() {
        _isEnabled = status;
      });
    }
  }

  bool _getCurrentEnableStatus() {
    if (widget.enableWhen != null) {
      return widget.enableWhen!();
    } else if (widget.fieldControllers != null) {
      if (widget.fieldControllers != null &&
          widget.fieldControllers!.isNotEmpty) {
        for (final controller in widget.fieldControllers!) {
          if (controller.text.trim().isEmpty) {
            return false;
          }
        }
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final buttonTheme = AppThemesProvider.of(context).actionButtonTheme;

    widget.textStyle ??= AppModule.I.appStyles.text3().copyWith(
          decoration:
              widget.actionTextDecoration ?? buttonTheme.actionTextDecoration,
          fontWeight: widget.actionTextWeight ?? buttonTheme.actionTextWeight,
          color: widget.actionTextColor ??
              buttonTheme.actionTextColor ??
              ((widget.withBorder ?? buttonTheme.withBorder)
                  ? null
                  : AppModule.I.appColors.white),
          fontSize: widget.actionTextSize ?? buttonTheme.actionTextSize,
          height: 1,
        );

    return TapEffect(
      onTap: !_isEnabled || widget.showLoading ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 450),
        width: (widget.fitsFullWidth ?? buttonTheme.fitsFullWidth)
            ? double.maxFinite
            : widget.width,
        height: (widget.fitsFullWidth ?? buttonTheme.fitsFullWidth)
            ? null
            : widget.height,
        margin: widget.margin ?? buttonTheme.margin,
        decoration: BoxDecoration(
          color: _getButtonBackgroundColor(buttonTheme),
          gradient: (widget.enableGradient ?? buttonTheme.enableGradient)
              ? (widget.backgroundGradient ?? buttonTheme.backgroundGradient)
              : null,
          borderRadius: widget.borderRadius ??
              buttonTheme.borderRadius ??
              BorderRadius.circular(AppDimensions.radius_10),
          border: _getButtonBorder(buttonTheme),
          boxShadow: widget.boxShadow,
        ),
        child: TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
            padding: widget.padding ??
                buttonTheme.padding ??
                const EdgeInsets.all(AppDimensions.defaultSidePadding),
            fixedSize: _calculateButtonSize(buttonTheme.fitsFullWidth),
            shape: RoundedRectangleBorder(
              borderRadius: widget.borderRadius ??
                  buttonTheme.borderRadius ??
                  BorderRadius.circular(AppDimensions.radius_10),
            ),
            textStyle: widget.textStyle ?? buttonTheme.textStyle,
            foregroundColor: widget.actionTextColor ??
                buttonTheme.actionTextColor ??
                Colors.white,
          ),
          child: Center(
            child: widget.showLoading
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.loadingText != null) ...[
                        Text(
                          widget.loadingText!,
                          style: widget.textStyle ?? buttonTheme.textStyle,
                        ),
                        const SizedBox(width: AppDimensions.dimen_5),
                      ],
                      SizedBox(
                        width: 20.0,
                        height: 22.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            (widget.loaderColor ?? buttonTheme.loaderColor),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.leadingIcon != null)
                        Flexible(child: widget.leadingIcon!),
                      if (widget.leadingIcon != null &&
                          widget.text.trim().isNotEmpty)
                        SizedBox(
                          width: widget.leadingSpacing ??
                              AppDimensions.defaultIconButtonSidePadding,
                        ),
                      Text(
                        widget.text,
                        style: widget.textStyle ?? buttonTheme.textStyle,
                      ),
                      if (widget.trailingIcon != null)
                        Flexible(child: widget.trailingIcon!),
                      if (widget.trailingIcon != null &&
                          widget.text.trim().isNotEmpty)
                        SizedBox(
                          width: widget.trailingSpacing ??
                              AppDimensions.defaultIconButtonSidePadding,
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Border? _getButtonBorder(ActionButtonTheme buttonTheme) {
    if (widget.withBorder ?? buttonTheme.withBorder) {
      return Border.all(
        color: widget.borderColor ??
            buttonTheme.borderColor ??
            (!_isEnabled || widget.onPressed == null
                ? AppModule.I.appColors.white.withOpacity(0.5)
                : AppModule.I.appColors.lightGrey),
        width: 1.0,
      );
    }

    return null;
  }

  Color? _getButtonBackgroundColor(ActionButtonTheme buttonTheme) {
    final backgroundColor =
        widget.backgroundColor ?? buttonTheme.backgroundColor;

    if (!_isEnabled || widget.onPressed == null) {
      if (widget.backgroundColor == AppModule.I.appColors.transparent) {
        return widget.backgroundColor;
      }

      if (widget.disabledColor != null) return widget.disabledColor;

      if (buttonTheme.disabledColor != null) return buttonTheme.disabledColor;

      return backgroundColor.withOpacity(0.5);
    }

    return backgroundColor;
  }

  Size? _calculateButtonSize(bool fitsFullWidth) {
    if (widget.fitsFullWidth ?? fitsFullWidth) {
      return const Size.fromWidth(double.maxFinite);
    }

    if (widget.width != null && widget.height == null) {
      return Size.fromWidth(widget.width!);
    }

    if (widget.width == null && widget.height != null) {
      return Size.fromHeight(widget.height!);
    }

    if (widget.width != null && widget.height != null) {
      return Size(widget.width!, widget.height!);
    }

    return null;
  }
}

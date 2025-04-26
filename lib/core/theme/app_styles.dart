import 'package:flutter/material.dart';

import '../../app_module.dart';
import 'app_dimensions.dart';
import 'themes.dart';

/// The [AppFontSizes] class defines the font weights used in the app.
/// It contains static constants for different font weights, which are used
/// throughout the app to maintain a consistent typography style.
class AppFontWeights {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w200;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

/// The [AppStyles] class defines the default styles used in the app.
/// It contains static constants for different text styles that are used
/// throughout the app to maintain a consistent typography style.
abstract class AppStyles {
  AppScaffoldTheme get defaultScaffoldTheme => AppScaffoldTheme();
  ActionButtonTheme get defaultActionButtonTheme => ActionButtonTheme();

  /// Text Styles
  /// *​Figma Styles ​to App Style Map *
  //? ​Figma              ->            App​
  //! ​Headline 1         ->            header1​
  //! ​Headline 2         ->            header2​
  //! ​Headline 3         ->            header3
  //! ​Headline 4         ->            header4​
  //! ​Headline 5         ->            header5​
  //! ​Paragraph 1        ->            text1​
  //! ​Paragraph 2        ->            text2
  //! ​Paragraph 3        ->            text3​
  //! ​tab 1              ->            tab1​
  //! ​tab 2              ->            tab2​
  //! ​Muted text         ->            mutedText​
  //! ​Info text          ->            infoText​
  //! ​hyperlink text     ->            hiperlinkText​
  //! ​success text       ->            successText​
  //! ​Warning text       ->            warningText​
  //! ​Error text         ->            errorText

  TextStyle header1({Color? color, double? fontSize, double? lineHeight}) {
    color ??= AppModule.I.appColors.darkTextColor;
    fontSize ??= AppFontSizes.header1;
    lineHeight ??= 60;

    return TextStyle(
      fontFamily: AppModule.I.defaultFontFamily,
      fontWeight: AppFontWeights.medium,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      color: color,
    );
  }

  TextStyle header2({Color? color, double? fontSize, double? lineHeight}) {
    color ??= AppModule.I.appColors.darkTextColor;
    fontSize ??= AppFontSizes.header2;
    lineHeight ??= 50;

    return TextStyle(
      fontFamily: AppModule.I.defaultFontFamily,
      fontWeight: AppFontWeights.regular,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      color: color,
    );
  }

  TextStyle header3({Color? color, double? fontSize, double? lineHeight}) {
    color ??= AppModule.I.appColors.darkTextColor;
    fontSize ??= AppFontSizes.header3;
    lineHeight ??= 54;

    return TextStyle(
      fontFamily: AppModule.I.defaultFontFamily,
      fontWeight: AppFontWeights.semiBold,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      color: color,
    );
  }

  TextStyle header4({Color? color, double? fontSize, double? lineHeight}) {
    color ??= AppModule.I.appColors.darkTextColor;
    fontSize ??= AppFontSizes.header4;
    lineHeight ??= 36;

    return TextStyle(
      fontFamily: AppModule.I.defaultFontFamily,
      fontWeight: AppFontWeights.medium,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      color: color,
    );
  }

  TextStyle header5({Color? color, double? fontSize, double? lineHeight}) {
    color ??= AppModule.I.appColors.darkTextColor;
    fontSize ??= AppFontSizes.header5;
    lineHeight ??= 27;

    return TextStyle(
      fontFamily: AppModule.I.defaultFontFamily,
      fontWeight: AppFontWeights.medium,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      color: color,
    );
  }

  TextStyle text1({Color? color, double? fontSize, double? lineHeight}) {
    color ??= AppModule.I.appColors.darkTextColor;
    fontSize ??= AppFontSizes.text1;
    lineHeight ??= 20;

    return TextStyle(
      fontFamily: AppModule.I.defaultFontFamily,
      fontWeight: AppFontWeights.medium,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      color: color,
    );
  }

  TextStyle get mutedText {
    return text1().copyWith(
      color: AppModule.I.appColors.mutedTextColor,
      fontWeight: AppFontWeights.regular,
    );
  }

  TextStyle get infoText {
    return text1().copyWith(
      color: AppModule.I.appColors.infoTextColor,
      fontWeight: AppFontWeights.regular,
    );
  }

  TextStyle get hiperlinkText {
    return text1().copyWith(
      color: AppModule.I.appColors.hiperlinkTextColor,
      fontWeight: AppFontWeights.regular,
    );
  }

  TextStyle get successText {
    return text1().copyWith(
      color: AppModule.I.appColors.successTextColor,
      fontWeight: AppFontWeights.regular,
    );
  }

  TextStyle get warningText {
    return text1().copyWith(
      color: AppModule.I.appColors.warningTextColor,
      fontWeight: AppFontWeights.regular,
    );
  }

  TextStyle get errorText {
    return text1().copyWith(
      color: AppModule.I.appColors.errorTextColor,
      fontWeight: AppFontWeights.regular,
    );
  }

  TextStyle text2({
    Color? color,
    double? fontSize,
    double? lineHeight,
    bool isUnderlined = false,
  }) {
    color ??= AppModule.I.appColors.darkTextColor;
    fontSize ??= AppFontSizes.text2;
    lineHeight ??= 20;

    return TextStyle(
      fontFamily: AppModule.I.secondaryFontFamily,
      fontWeight: AppFontWeights.semiBold,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      color: color,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
    );
  }

  TextStyle text3({
    Color? color,
    double? fontSize,
    double? lineHeight,
    bool isUnderlined = false,
  }) {
    color ??= AppModule.I.appColors.darkTextColor;
    fontSize ??= AppFontSizes.text3;
    lineHeight ??= 20;

    return TextStyle(
      fontFamily: AppModule.I.defaultFontFamily,
      fontWeight: AppFontWeights.semiBold,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      color: color,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
    );
  }

  TextStyle tab1({Color? color, double? fontSize, double? lineHeight}) {
    color ??= AppModule.I.appColors.darkTextColor;
    fontSize ??= AppFontSizes.tab1;
    lineHeight ??= 15;

    return TextStyle(
      fontFamily: AppModule.I.secondaryFontFamily,
      fontWeight: AppFontWeights.semiBold,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      color: color,
      letterSpacing: 0,
    );
  }

  TextStyle tab2({Color? color, double? fontSize, double? lineHeight}) {
    color ??= AppModule.I.appColors.darkTextColor;
    fontSize ??= AppFontSizes.tab2;
    lineHeight ??= 13;

    return TextStyle(
      fontFamily: AppModule.I.secondaryFontFamily,
      fontWeight: AppFontWeights.medium,
      fontSize: fontSize,
      height: lineHeight / fontSize,
      color: color,
      letterSpacing: 0.20000000298023224,
    );
  }

  TextStyle get noText => const TextStyle(fontSize: 0, height: 0);
}

/// Default App Styles
class DefaultAppStyles extends AppStyles {
  DefaultAppStyles._();

  static final DefaultAppStyles _instance = DefaultAppStyles._();

  static DefaultAppStyles get I => _instance;
}

/// Default App Borders
/// This class is used to define the default borders used in the app.
class DefaultAppBorders extends AppBorders {
  DefaultAppBorders._();

  static final DefaultAppBorders _instance = DefaultAppBorders._();
  static DefaultAppBorders get I => _instance;
}

/// Default App Shadows
/// This class is used to define the default shadows used in the app.
class DefaultAppShadows extends AppShadows {
  DefaultAppShadows._();

  static final DefaultAppShadows _instance = DefaultAppShadows._();

  /// Getters
  static DefaultAppShadows get I => _instance;
  static DefaultAppShadows get instance => _instance;
}

/// The [AppShadows] class defines the shadows used in the app.
abstract class AppShadows {
  BoxShadow get defaultShadow => BoxShadow(
        offset: const Offset(0, 2),
        blurRadius: AppDimensions.radius_12,
        color: AppModule.I.appColors.black.withOpacity(0.08),
      );

  /// Add any new shadows here
}

/// The [AppBorders] class defines the borders used in the app.
abstract class AppBorders {
  /// Inputs
  OutlineInputBorder inputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppModule.I.appColors.white.withOpacity(0.1),
      width: 1.0,
    ),
    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
  );

  OutlineInputBorder inputFocusedBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppModule.I.appColors.white,
      width: 1.0,
    ),
    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
  );

  OutlineInputBorder inputErrorBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppModule.I.appColors.redShades.shade60,
      width: 1.0,
    ),
    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
  );

  /// Add any new borders here
}

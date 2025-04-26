import 'package:flutter/material.dart';

/// MainColor class similar to MaterialColor
///
/// So this have the purpose to set the custom
/// shape colors, that goes from 10 to 100 in 10 step increment
class MainColor extends ColorSwatch<int> {
  // ignore: use_super_parameters
  const MainColor(int primary, Map<int, Color> swatch) : super(primary, swatch);

  /// The lightest shade.
  Color get shade10 => this[10]!;

  /// The second lightest shade.
  Color get shade20 => this[20]!;

  /// The third lightest shade.
  Color get shade30 => this[30]!;

  /// The fourth lightest shade.
  Color get shade40 => this[40]!;

  /// The fifth lightest shade.
  Color get shade50 => this[50]!;

  /// The default shade.
  Color get shade60 => this[60]!;

  /// The fourth darkest shade.
  Color get shade70 => this[70]!;

  /// The third darkest shade.
  Color get shade80 => this[80]!;

  /// The second darkest shade.
  Color get shade90 => this[90]!;

  /// The darkest shade.
  Color get shade100 => this[100]!;
}

/// AppColors class is an abstract class that defines a set of colors
/// to be used throughout the application. It provides a consistent
/// color scheme for the app, making it easier to maintain and update
/// the app's appearance. The colors are defined as getters, allowing
/// for easy access and customization. The class also includes a
/// DefaultAppColors implementation, which provides a default set of
/// colors for the app. This allows for easy theming and customization
/// of the app's appearance without having to modify the individual
/// color values throughout the codebase.
/// The DefaultAppColors class is a singleton, ensuring that there is
/// only one instance of the colors throughout the app. This helps
/// to maintain a consistent color scheme and makes it easier to
/// update the colors in the future.
///
abstract class AppColors {
  Color get transparent => Colors.transparent;

  /// Text Colors
  Color get darkTextColor => const Color(0xFF3A3A3A);
  Color get mutedTextColor => const Color(0xFFBEBEBD);
  Color get infoTextColor => const Color(0xFF002564);
  Color get hiperlinkTextColor => const Color(0xFF70AFE1);
  Color get successTextColor => const Color(0xFF36B16B);
  Color get warningTextColor => const Color(0xFFFF8700);
  Color get errorTextColor => const Color(0xFFCB3313);

  Color get darkGrey => const Color(0xFF666666);

  Color get mediumGrey => const Color(0xFF939598);
  Color get mediumGreyShade90 => const Color(0xFFAFAFAF);

  Color get lightGrey => const Color(0xFFD2D2D2);

  Color get white => const Color(0xFFFFFFFF);

  Color get black => const Color(0xFF000000);

  Color get canvasColor => const Color(0xFFFFFFFF);
  Color get canvasColorShade10 => const Color(0xFFFFFAF7);

  Color get darkCanvasColor => const Color(0xFFFAEEE5);

  Color get lightCanvasColor => const Color(0xFFFFFAF7);

  Color get buttonBGColor => const Color(0xFF333333);

  Color? get fieldFillColor => null;

  int get redHex => 0xFFDC2A63;
  MainColor get redShades => MainColor(
        redHex,
        <int, Color>{
          60: const Color(0xFFDC2A63),
          100: Color(redHex),
        },
      );

  int get greenHex => 0xFF59C270;
  MainColor get greenShades => MainColor(
        greenHex,
        <int, Color>{
          60: const Color(0xFF59C270).withOpacity(0.6),
          100: Color(greenHex),
        },
      );

  Color get primaryColor => const Color.fromRGBO(255, 148, 25, 0.85);

  Color get lightPrimaryColor => const Color(0xFFAAA3E7);

  Color get imagePreviewOverlayColor => const Color(0xFFD9D9D9);

  Color get fieldBorderColor => const Color(0xFF939598);

  Color get searchFieldHintColor => const Color(0xFF939598);

  Color get chipBorderColor => const Color(0xFFE5E5E5);

  Color get shadow => const Color(0xFFE4CFBE);

  Color get placeholderGreyColor => const Color(0xFFD9D9D9);

  Color get salmon => const Color(0xFFE67C7C);

  Color get grey => const Color(0xFF8A8A8A);

  Color get containerShadowColor => const Color(0xFF352C80).withOpacity(0.08);

  Color get bottomNavigationBarShadowColor =>
      const Color(0xFFC8C8C8).withOpacity(0.4);

  Color get dividerColor => const Color(0xFFC0C0C0);

  Color get fieldHintColor => const Color(0xFFB6B6B6);

  Color get defaultOverlayColor => const Color.fromRGBO(29, 32, 53, 0.5);

  Color get defaultGradientStartColor => primaryColor;
  Color get defaultGradientEndColor => const Color(0xFF6F52E5);

  Color get settingsGradientStartColor => primaryColor;
  Color get settingsGradientEndColor => const Color(0xFF6F52E5);

  Color get accentColor => const Color(0xFFDBE2FF);

  Color get dashboardBtnBGColor => white;

  Color get backBtnBGColor => white;

  Color get tabbarBGColor => darkTextColor;

  Color get cardColor => white;

  Color get errorColor => salmon;

  Color get validColor => greenShades;

  Color get pendingColor => Colors.amber;

  Color get progressBarBGColor => const Color(0xFF6F52E5);

  Color get fieldValidBGColor => const Color(0xFFD6EFE1);

  Color get fieldValidBorderColor => const Color(0xFF8FF3CF);

  Color get fieldErrorBGColor => const Color(0xFFFFDBDB);

  Color get fieldErrorBorderColor => const Color(0xABFF5E5E);

  Color get shimmerBaseColor => white;

  Color get shimmerHighlightColor => canvasColor;
}

/// Default App Colors instance.
class DefaultAppColors extends AppColors {
  DefaultAppColors._();

  static final DefaultAppColors _instance = DefaultAppColors._();
  static DefaultAppColors get I => _instance;
}

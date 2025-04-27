import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_colors.dart';
import 'core/theme/app_styles.dart';
import 'core/theme/themes.dart';
import 'core/widgets/app_toast/app_toast.dart';

/// Blocs Map State Management

class AppModule {
  static final AppModule _mainModule = AppModule._();

  static AppModule get instance => _mainModule;

  static AppModule get I => _mainModule;

  /// Stores the id of the current logged is user
  String? currentUserId;

  /// Stores the font-family name of the current app's font
  String defaultFontFamily = 'Source Code Pro';
  String secondaryFontFamily = 'Source Code Pro';

  /// Store the device current default timezone
  String deviceDefaultTimezone = '';

  /// Store the device locked state
  bool deviceLocked = false;

  /// Stream controller to control showing toasts in the app.
  late final StreamController<AppToastData> toastController;

  bool _useMaterial3 = true;

  NavigatorObserver? _analyticsObserver;

  late AppColors _appColors = DefaultAppColors.I;
  late AppStyles _appStyles = DefaultAppStyles.I;
  late AppBorders _appBorders = DefaultAppBorders.I;
  late AppShadows _appShadows = DefaultAppShadows.I;

  late ThemeData _defaultTheme =
      DefaultAppThemes.I.defaultTheme(useMaterial3: _useMaterial3);

  BuildContext get _context => navigatorKey.currentState!.context;
  MediaQueryData get _mediaQuery => MediaQuery.of(_context);

  NavigatorObserver? get analyticsObserver => _analyticsObserver;

  AppColors get appColors => _appColors;
  AppStyles get appStyles => _appStyles;
  AppBorders get appBorders => _appBorders;
  AppShadows get appShadows => _appShadows;

  ThemeData get defaultTheme => _defaultTheme;
  Size get screenSize => _mediaQuery.size;
  double get screenWidth => _mediaQuery.size.width;
  double get screenHeight => _mediaQuery.size.height;
  Orientation get orientation => _mediaQuery.orientation;

  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;
  bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;
  bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;
  bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;

  void setAppColors(AppColors colors) => _appColors = colors;
  void setAppStyles(AppStyles styles) => _appStyles = styles;
  void setAppBorders(AppBorders borders) => _appBorders = borders;
  void setAppShadows(AppShadows shadows) => _appShadows = shadows;
  void setAppThteme(ThemeData theme) => _defaultTheme = theme;

  set useMaterial3(bool useMaterial3) => _useMaterial3 = useMaterial3;

  AppModule._() {
    navigatorKey = GlobalKey<NavigatorState>();
    scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
    routeObserver = RouteObserver<ModalRoute<void>>();
    toastController = StreamController<AppToastData>.broadcast();
  }

  late String environmentFlavor = const String.fromEnvironment(
    'flavor',
    defaultValue: 'production',
  );
  late final bool isDevMode = environmentFlavor == 'dev';
  late final GlobalKey<NavigatorState> navigatorKey;
  late final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  late final RouteObserver routeObserver;

  set setEnvironment(String flavor) {
    environmentFlavor = flavor;
  }

  void unfocus() => FocusScope.of(_context).unfocus();
  void pop<T extends Object?>([T? result]) =>
      Navigator.of(_context).pop(result);

  void startApp(Widget app) async => runApp(app);
}

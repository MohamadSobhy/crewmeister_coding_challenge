import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'app_module.dart';
import 'app_widget.dart';
import 'injection_container.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // preserves the splash untill we close it.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// initialize service locator
  await initServiceLocator();

  /// Init App Colors and Styles
  AppModule.I
    ..useMaterial3 = true
    // Set the default Font Family for the app
    ..defaultFontFamily = 'Source Code Pro'
    // Set the secondary Font Family for the app
    ..secondaryFontFamily = 'Source Code Pro';

  // TODO: In case you need to change the app colors and styles, Do it like that and then refresh the state
  // ..setAppColors(MobileAppColors.instance)
  // ..setAppStyles(MobileAppStyles.instance)
  // ..setAppShadows(MobileAppShadows.instance)
  // ..setAppBorders(MobileAppBorders.instance);

  Provider.debugCheckInvalidValueType = null;

  // Close the splash screen after 2 seconds
  Future.delayed(const Duration(seconds: 2), () {
    FlutterNativeSplash.remove();
  });

  runApp(const CrewmeisterCodingChallengeApp());
}

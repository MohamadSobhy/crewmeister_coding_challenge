import 'package:flutter/material.dart';

import '../../../app_module.dart';
import '../themes.dart';

/// The [AppThemesProvider] is an InheritedWidget that provides the app's theme data
/// to its descendants. It allows for easy access to the app's theme settings
/// throughout the widget tree. The provider holds the current theme settings
/// and can be used to update the theme dynamically if needed.
/// It also provides default themes for the app's scaffold and action button.
/// The [AppThemesProvider] is a singleton that can be accessed using the [of] method.
/// It is important to note that the [AppThemesProvider] should be used in conjunction
/// with the [AppModule] to ensure that the app's theme settings are consistent
/// throughout the app.
/// The [AppThemesProvider] is a part of the app's theme management system,
/// which includes the [AppColors], [AppStyles], [AppBorders], and [AppShadows] classes.
/// These classes work together to provide a consistent and customizable theme
/// for the app. The [AppThemesProvider] is responsible for providing the theme data
/// to the app's widgets, while the other classes handle the actual styling
/// and theming of the app's UI components.

class AppThemesProvider extends InheritedWidget {
  late final AppScaffoldTheme scaffoldTheme;
  late final ActionButtonTheme actionButtonTheme;

  static late Widget _child;

  AppThemesProvider({
    super.key,
    AppScaffoldTheme? scaffoldTheme,
    ActionButtonTheme? actionButtonTheme,
    required super.child,
  }) {
    _child = child;
    this.scaffoldTheme = scaffoldTheme ?? defaultScaffoldTheme;
    this.actionButtonTheme = actionButtonTheme ?? defaultActionButtonTheme;
  }

  static AppScaffoldTheme defaultScaffoldTheme =
      AppModule.I.appStyles.defaultScaffoldTheme;
  static ActionButtonTheme defaultActionButtonTheme =
      AppModule.I.appStyles.defaultActionButtonTheme;

  static AppThemesProvider of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<AppThemesProvider>();

    if (provider == null) {
      return AppThemesProvider(
        scaffoldTheme: defaultScaffoldTheme,
        actionButtonTheme: defaultActionButtonTheme,
        child: _child,
      );
    }

    return provider;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

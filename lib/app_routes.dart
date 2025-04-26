import 'package:flutter/material.dart';

import 'app_module.dart';
import 'core/theme/app_styles.dart';
import 'core/widgets/app_scaffold.dart';
import 'features/absences/presentation/pages/absences_list_page.dart';

class AppRoutes {
  AppRoutes._();

  static final Map<String, WidgetBuilder> _routes = {
    '/': (ctx) => const AbsencesListPage(),
    AbsencesListPage.routeName: (ctx) => const AbsencesListPage(),
  };

  static AppRoute<dynamic> onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name;
    final builder = AppRoutes._routes[routeName] ?? _pageNotFoundBuilder;

    return AppRoute(
      builder: builder,
      settings: settings,
      fade: true,
    );
  }

  static Widget _pageNotFoundBuilder(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Text(
          '404 Page Not Found!',
          style: AppModule.I.appStyles
              .header3(color: AppModule.I.appColors.errorColor, fontSize: 24)
              .copyWith(fontWeight: AppFontWeights.bold),
        ),
      ),
    );
  }
}

extension on RouteSettings {
  bool get fade =>
      arguments != null &&
      arguments is Map &&
      (arguments as Map)['fade'] == true;
}

class AppRoute<T> extends MaterialPageRoute<T> {
  final bool fade;

  AppRoute({
    required super.builder,
    required RouteSettings super.settings,
    super.maintainState,
    this.fade = false,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (fade || settings.fade) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeIn,
          reverseCurve: Curves.easeOut,
        ),
        child: child,
      );
    }

    return super.buildTransitions(
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}

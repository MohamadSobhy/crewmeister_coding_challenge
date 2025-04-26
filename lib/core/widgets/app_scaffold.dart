import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../app_module.dart';
import '../theme/providers/app_themes_provider.dart';
import 'app_background.dart';

class AppScaffold extends StatelessWidget {
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;
  final Gradient? Function(double?)? backgroundGradientBuilder;
  final double? backgroundGradientOpacity;
  final bool? animateGradient;
  final int? gradientStart;
  final Function(AnimationController)? onGradientAnimationCreated;
  final Function()? onUnfocus;

  const AppScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = false,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.backgroundGradientBuilder,
    this.backgroundGradientOpacity,
    this.animateGradient,
    this.gradientStart,
    this.onGradientAnimationCreated,
    this.onUnfocus,
  });

  @override
  Widget build(BuildContext context) {
    final scaffoldTheme = AppThemesProvider.of(context).scaffoldTheme;

    return GestureDetector(
      onTap: AppModule.I.unfocus,
      onTapDown: (_) {
        AppModule.I.unfocus();

        if (onUnfocus != null) onUnfocus!();
      },
      child: Scaffold(
        key: key,
        appBar: appBar,
        body: backgroundColor == null && scaffoldTheme.backgroundColor == null
            ? AppBackground(
                gradientBuilder: backgroundGradientBuilder ??
                    scaffoldTheme.backgroundGradientBuilder,
                gradientOpacity: backgroundGradientOpacity ??
                    scaffoldTheme.backgroundGradientOpacity,
                animateGradient:
                    animateGradient ?? scaffoldTheme.animateGradient,
                gradientStart: gradientStart ?? scaffoldTheme.gradientStart,
                onGradientAnimationCreated: onGradientAnimationCreated,
                child: SafeArea(
                  top: appBar != null,
                  bottom: bottomNavigationBar != null,
                  child: body ?? const SizedBox(),
                ),
              )
            : SafeArea(
                top: appBar != null,
                bottom: bottomNavigationBar != null,
                child: body ?? const SizedBox(),
              ),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        persistentFooterButtons: persistentFooterButtons,
        persistentFooterAlignment: persistentFooterAlignment,
        drawer: drawer,
        onDrawerChanged: onDrawerChanged,
        endDrawer: endDrawer,
        onEndDrawerChanged: onEndDrawerChanged,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        backgroundColor: backgroundColor ?? scaffoldTheme.backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        primary: primary,
        drawerDragStartBehavior: drawerDragStartBehavior,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        drawerScrimColor: drawerScrimColor,
        drawerEdgeDragWidth: drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        restorationId: restorationId,
      ),
    );
  }
}

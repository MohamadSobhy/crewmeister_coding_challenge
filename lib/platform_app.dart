import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_module.dart';
import 'app_routes.dart';
import 'core/widgets/app_toast/app_toast.dart';
import 'core/widgets/app_toast/app_toast_view.dart';
import 'features/absences/presentation/pages/absences_list_page.dart';
import 'generated/l10n.dart';

class PlatformApp extends StatelessWidget {
  const PlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          // TODO: Uncomment this when localization is implemented to update app ocalization
          // Consumer<LocalizationProvider>(
          //   builder: (ctx, provider, _) {
          //     return

          MaterialApp(
            title: 'Crewmeister Coding Challenge',
            debugShowCheckedModeBanner: false,
            theme: AppModule.I.defaultTheme,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            // TODO: Uncomment this when localization is implemented to update app ocalization
            locale: const Locale('en', ''), //provider.currentLocale,
            scaffoldMessengerKey: AppModule.I.scaffoldMessengerKey,
            navigatorKey: AppModule.I.navigatorKey,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            initialRoute: AbsencesListPage.routeName,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              debugPrint('Device locale: ${deviceLocale!.languageCode}');

              final supportedLanguages =
                  supportedLocales.map((e) => e.languageCode).toList();

              if (supportedLanguages.contains(deviceLocale.languageCode)) {
                return Locale(deviceLocale.languageCode, '');
              }

              return supportedLocales.first;
            },
            //   );
            // },
          ),
          StreamBuilder<AppToastData>(
            stream: AppModule.I.toastController.stream,
            builder: (context, snapshot) {
              return snapshot.data?.message != null &&
                      snapshot.data!.message.trim().isNotEmpty
                  ? Positioned(
                      key: UniqueKey(),
                      bottom:
                          defaultTargetPlatform == TargetPlatform.iOS ? 40 : 20,
                      left: 0,
                      right: 0,
                      child: SafeArea(
                        child: AppToastView(toast: snapshot.data!),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_module.dart';
import 'core/theme/app_dimensions.dart';
import 'core/theme/providers/app_themes_provider.dart';
import 'core/theme/themes.dart';
import 'features/absences/presentation/absences_bloc/absences_bloc.dart';
import 'features/absences/presentation/controllers/absences_filters_controller.dart';
import 'injection_container.dart';
import 'platform_app.dart';

class CrewmeisterCodingChallengeApp extends StatelessWidget {
  const CrewmeisterCodingChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (ctx) {
            final bloc = servLocator<AbsencesBloc>();
            bloc.add(GetListOfAbsencesEvent());
            return bloc;
          },
        ),
        ChangeNotifierProvider.value(
          value: servLocator<AbsencesFiltersController>(),
        ),
      ],
      child: AppThemesProvider(
        scaffoldTheme: AppScaffoldTheme(
          backgroundGradientOpacity: 1,
          backgroundColor: AppModule.I.appColors.canvasColor,
        ),
        actionButtonTheme:
            AppModule.I.appStyles.defaultActionButtonTheme.copyWith(
          enableGradient: true,
          textStyle: AppModule.I.appStyles.text3(),
          borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
          borderColor: AppModule.I.appColors.primaryColor,
          disabledColor: AppModule.I.appColors.primaryColor.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(
            vertical: kIsWeb ? AppDimensions.dimen_22 : AppDimensions.dimen_16,
          ),
        ),
        child: const PlatformApp(),
      ),
    );
  }
}

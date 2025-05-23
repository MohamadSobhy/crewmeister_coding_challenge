import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../app_module.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_styles.dart';

class AbsenceListShimmerView extends StatelessWidget {
  const AbsenceListShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.defaultSideMargin,
        vertical: AppDimensions.smallSidePadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Absences (##)',
            style: AppModule.I.appStyles
                .header4(
                  color: AppModule.I.appColors.primaryColor,
                )
                .copyWith(fontWeight: AppFontWeights.black),
          ),
          Divider(color: AppModule.I.appColors.lightGrey),
          Expanded(
            child: ListView.builder(
              itemCount: 12,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: AppDimensions.dimen_8),
                  child: AbsenceItemShimmerLoadingView(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AbsenceItemShimmerLoadingView extends StatelessWidget {
  const AbsenceItemShimmerLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppModule.I.appColors.darkCanvasColor.withValues(alpha: 0.5),
      shadowColor: AppModule.I.appColors.white,
      child: Shimmer.fromColors(
        baseColor: AppModule.I.appColors.darkCanvasColor.withValues(alpha: 0.5),
        highlightColor: AppModule.I.appColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(
            AppDimensions.defaultSidePadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      '####### ######',
                      style: AppModule.I.appStyles
                          .header5(color: AppModule.I.appColors.primaryColor)
                          .copyWith(fontWeight: AppFontWeights.bold),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.dimen_8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.dimen_8,
                      vertical: AppDimensions.dimen_4,
                    ),
                    child: Text(
                      '#####',
                      style: AppModule.I.appStyles
                          .text3()
                          .copyWith(fontWeight: AppFontWeights.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.dimen_5),
              Text('Period (# Days)'),
              Text(
                'From ####-##-## to ####-##-##',
                style: AppModule.I.appStyles.text3(
                  color: AppModule.I.appColors.grey,
                ),
              ),
              const SizedBox(height: AppDimensions.dimen_5),
              Text('Member Note'),
              Text(
                "###### ####### ###### ###### #######  ### ## ##### ### ######",
                style: AppModule.I.appStyles.text3(
                  color: AppModule.I.appColors.grey,
                ),
              ),
              const SizedBox(height: AppDimensions.dimen_5),
              Text('Admitter Note'),
              Text(
                "###### ####### ###### ###### #######  ### ## ##### ### ######",
                style: AppModule.I.appStyles.text3(
                  color: AppModule.I.appColors.grey,
                ),
              ),
              const SizedBox(height: AppDimensions.dimen_5),
              Text('Status'),
              const SizedBox(height: AppDimensions.dimen_2),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.dimen_8,
                      vertical: AppDimensions.dimen_4,
                    ),
                    child: Text(
                      "######",
                      style: AppModule.I.appStyles
                          .text3(color: AppModule.I.appColors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

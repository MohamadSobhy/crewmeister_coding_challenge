import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_module.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/widgets/tap_effect.dart';
import '../controllers/absences_filters_controller.dart';
import '../pages/absences_list_page.dart';
import 'absences_filters_view.dart';

class AbsencesFiltersIcon extends StatefulWidget {
  const AbsencesFiltersIcon({super.key});

  @override
  State<AbsencesFiltersIcon> createState() => _AbsencesFiltersIconState();
}

class _AbsencesFiltersIconState extends State<AbsencesFiltersIcon> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AbsencesFiltersController>(
      builder: (ctx, controller, _) {
        return TapEffect(
          onTap: () => _showFiltersBottomSheet(context),
          child: Stack(
            children: [
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.filter_list,
                  color: AppModule.I.appColors.grey,
                ),
              ),
              if (controller.filtersCount > 0)
                Container(
                  padding: const EdgeInsets.all(AppDimensions.dimen_6),
                  decoration: BoxDecoration(
                    color: AppModule.I.appColors.primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppModule.I.appColors.canvasColor,
                      width: AppDimensions.dimen_2,
                    ),
                  ),
                  child: Text(
                    controller.filtersCount.toString(),
                    style: AppModule.I.appStyles
                        .text3(color: AppModule.I.appColors.white),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showFiltersBottomSheet(BuildContext context) async {
    final shouldRefresh = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: AppModule.I.appColors.darkCanvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.dimen_16),
        ),
      ),
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: context.read<AbsencesFiltersController>(),
          child: AbsencesFiltersView(),
        );
      },
    );

    if (shouldRefresh != null && shouldRefresh) {
      Future.delayed(Duration(milliseconds: 400), () {
        // ignore: use_build_context_synchronously
        AbsencesListPage.refreshAbsencesList(context);
      });
    }
  }
}

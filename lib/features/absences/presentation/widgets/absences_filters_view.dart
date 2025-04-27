import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../app_module.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/app_action_button.dart';
import '../../../../core/widgets/app_drop_down_menu.dart';
import '../../../../core/widgets/tap_effect.dart';
import '../../../../generated/l10n.dart';
import '../../domain/enums/absence_type.dart';
import '../controllers/absences_filters_controller.dart';

class AbsencesFiltersView extends StatefulWidget {
  const AbsencesFiltersView({super.key});

  @override
  State<AbsencesFiltersView> createState() => _AbsencesFiltersViewState();
}

class _AbsencesFiltersViewState extends State<AbsencesFiltersView> {
  AbsenceType? _selectedAbsenceType;
  String? _selectedDate;

  @override
  void initState() {
    final controller = context.read<AbsencesFiltersController>();
    _selectedAbsenceType = controller.selectedAbsenceType;
    _selectedDate = controller.selectedDate;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(
          AppDimensions.defaultSideMargin,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translations.filters,
                  style: AppModule.I.appStyles
                      .header4(color: AppModule.I.appColors.primaryColor)
                      .copyWith(fontWeight: AppFontWeights.black),
                ),
                TapEffect(
                  onTap: _clearFitlers,
                  child: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.refresh,
                      color: AppModule.I.appColors.errorColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.dimen_16),
            Text(
              translations.select_absence_type,
              style: AppModule.I.appStyles.text3(),
            ),
            const SizedBox(height: AppDimensions.dimen_8),
            AppDropdownMenu<AbsenceType>(
              list: [AbsenceType.sickness, AbsenceType.vacation],
              valueFormatter: (absence) {
                return absence.name;
              },
              onSelect: (absenceType) => _selectedAbsenceType = absenceType,
              currentValue: _selectedAbsenceType,
            ),
            const SizedBox(height: AppDimensions.dimen_16),
            Text(
              translations.select_absence_date,
              style: AppModule.I.appStyles.text3(),
            ),
            const SizedBox(height: AppDimensions.dimen_8),
            TapEffect(
              onTap: _openDatePicker,
              child: AppDropdownMenu(
                key: UniqueKey(),
                valueFormatter: (_) => '',
                hintText: _selectedDate != null
                    ? DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(_selectedDate!))
                    : '',
              ),
            ),
            const SizedBox(height: AppDimensions.dimen_20),
            AppActionButton.submit(
              text: translations.save,
              actionTextColor: AppModule.I.appColors.darkTextColor,
              onPressed: _saveAbsencesFilters,
            ),
            const SizedBox(height: AppDimensions.dimen_16),
          ],
        ),
      ),
    );
  }

  void _saveAbsencesFilters() {
    final controller = context.read<AbsencesFiltersController>();

    if (_selectedAbsenceType != null) {
      controller.setSelectedAbsenceType(_selectedAbsenceType!);
    }

    if (_selectedDate != null) {
      controller.setSelectedDate(_selectedDate!);
    }

    AppModule.I.pop(true);
  }

  void _clearFitlers() {
    final controller = context.read<AbsencesFiltersController>();
    controller.clearFilters();

    AppModule.I.pop(true);
  }

  void _openDatePicker() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 100 * 256)),
      lastDate: DateTime.now().add(Duration(days: 10 * 256)),
      initialDate: DateTime.tryParse(_selectedDate ?? '') ?? DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date.toString();
      });
    }
  }
}

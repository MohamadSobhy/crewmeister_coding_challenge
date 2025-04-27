import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';

import '../../../../app_module.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/tap_effect.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/absence.dart';

class AbsenceItemView extends StatelessWidget {
  final Absence absence;

  const AbsenceItemView({super.key, required this.absence});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return TapEffect(
      onTap: () {
        final Event event = Event(
          title: absence.member.name,
          description: absence.type.name,
          location: '',
          startDate: DateTime.tryParse(absence.startDate) ?? DateTime.now(),
          endDate: DateTime.tryParse(absence.endDate) ?? DateTime.now(),
          iosParams: IOSParams(reminder: Duration(hours: 1), url: ''),
          androidParams: AndroidParams(
            emailInvites: [],
          ),
        );

        Add2Calendar.addEvent2Cal(event);
      },
      child: Card(
        elevation: 0,
        color: AppModule.I.appColors.darkCanvasColor,
        shadowColor: AppModule.I.appColors.white,
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
                      absence.member.name,
                      style: AppModule.I.appStyles
                          .header5(color: AppModule.I.appColors.primaryColor)
                          .copyWith(fontWeight: AppFontWeights.bold),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.dimen_8),
                  Container(
                    decoration: BoxDecoration(
                      color: absence.type.color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.dimen_8,
                      vertical: AppDimensions.dimen_4,
                    ),
                    child: Text(
                      absence.type.name,
                      style: AppModule.I.appStyles
                          .text3(color: absence.type.labelColor)
                          .copyWith(fontWeight: AppFontWeights.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.dimen_5),
              Text(translations.periodFormatMsg(absence.durationInDays)),
              Text(
                translations.periodRangeMsg(absence.startDate, absence.endDate),
                style: AppModule.I.appStyles.text3(
                  color: AppModule.I.appColors.grey,
                ),
              ),
              if (absence.memberNote.isNotEmpty) ...[
                const SizedBox(height: AppDimensions.dimen_5),
                Text(translations.member_note),
                Text(
                  absence.memberNote,
                  style: AppModule.I.appStyles.text3(
                    color: AppModule.I.appColors.grey,
                  ),
                ),
              ],
              if (absence.admitterNote.isNotEmpty) ...[
                const SizedBox(height: AppDimensions.dimen_5),
                Text(translations.admitter_note),
                Text(
                  absence.admitterNote,
                  style: AppModule.I.appStyles.text3(
                    color: AppModule.I.appColors.grey,
                  ),
                ),
              ],
              const SizedBox(height: AppDimensions.dimen_5),
              Text(translations.status),
              const SizedBox(height: AppDimensions.dimen_2),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: absence.statusColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.dimen_8,
                      vertical: AppDimensions.dimen_4,
                    ),
                    child: Text(
                      absence.status,
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

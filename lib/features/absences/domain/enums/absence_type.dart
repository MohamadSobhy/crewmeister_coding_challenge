// This file defines an enumeration for different types of absences.
// The `AbsenceType` enum has three values:
// - `sickness`: Represents a sickness absence.
// - `vacation`: Represents a vacation absence.
// - `unknown`: Represents an unknown absence type.
//
import 'package:crewmeister_coding_challenge/app_module.dart';
import 'package:flutter/services.dart';

enum AbsenceType {
  sickness,
  vacation,
  unknown;

  static AbsenceType fromName(String? type) {
    final absenceType = AbsenceType.values.firstWhere(
      (e) => e.name == type,
      orElse: () => AbsenceType.unknown,
    );

    return absenceType;
  }

  Color get color {
    switch (this) {
      case AbsenceType.sickness:
        return AppModule.I.appColors.salmon;
      case AbsenceType.vacation:
        return AppModule.I.appColors.canvasColor;
      case AbsenceType.unknown:
        return AppModule.I.appColors.grey;
    }
  }

  Color get labelColor {
    switch (this) {
      case AbsenceType.sickness:
        return AppModule.I.appColors.white;
      case AbsenceType.vacation:
        return AppModule.I.appColors.validColor;
      case AbsenceType.unknown:
        return AppModule.I.appColors.black;
    }
  }
}

// This file defines an enumeration for different types of absences.
// The `AbsenceType` enum has three values:
// - `sickness`: Represents a sickness absence.
// - `vacation`: Represents a vacation absence.
// - `unknown`: Represents an unknown absence type.
//
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
}

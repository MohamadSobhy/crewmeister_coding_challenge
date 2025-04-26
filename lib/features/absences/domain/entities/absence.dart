import 'package:equatable/equatable.dart';

import '../enums/absence_type.dart';

/// The [Absence] class represents an absence entity with various properties.
/// It extends the [Equatable] class to allow for value comparison based on its properties.
/// The class contains properties such as [admitterId], [admitterNote], [confirmedAt],
/// [createdAt], [crewId], [endDate], [id], [memberNote], [rejectedAt], [startDate],
/// [type], and [userId]. These properties represent different aspects of an absence.
abstract class Absence extends Equatable {
  final String? admitterId;
  final String admitterNote;
  final String confirmedAt;
  final String createdAt;
  final int crewId;
  final String endDate;
  final int id;
  final String memberNote;
  final String rejectedAt;
  final String startDate;
  final AbsenceType type;
  final int userId;

  const Absence({
    required this.admitterId,
    required this.admitterNote,
    required this.confirmedAt,
    required this.createdAt,
    required this.crewId,
    required this.endDate,
    required this.id,
    required this.memberNote,
    required this.rejectedAt,
    required this.startDate,
    required this.type,
    required this.userId,
  });
}

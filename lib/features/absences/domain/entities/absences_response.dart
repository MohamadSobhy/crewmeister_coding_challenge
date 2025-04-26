import 'package:equatable/equatable.dart';

import 'absence.dart';

abstract class AbsencesResponse extends Equatable {
  final int totalCount;
  final List<Absence> absences;

  const AbsencesResponse({required this.totalCount, required this.absences});
}

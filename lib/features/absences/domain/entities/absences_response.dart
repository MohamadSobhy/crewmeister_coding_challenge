import 'package:equatable/equatable.dart';

import 'absence.dart';

abstract class AbsencesResponse extends Equatable {
  final int count;
  final List<Absence> absences;

  const AbsencesResponse({required this.count, required this.absences});
}

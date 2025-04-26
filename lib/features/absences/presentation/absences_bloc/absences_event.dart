part of 'absences_bloc.dart';

abstract class AbsencesEvent extends Equatable {
  const AbsencesEvent();
}

class GetListOfAbsencesEvent extends AbsencesEvent {
  final bool paginate;
  final int pageSize;
  final AbsenceType? type;
  final DateTime? date;

  const GetListOfAbsencesEvent({
    this.paginate = false,
    this.pageSize = 10,
    this.type,
    this.date,
  });

  @override
  List<Object?> get props => [paginate, pageSize, type, date];
}

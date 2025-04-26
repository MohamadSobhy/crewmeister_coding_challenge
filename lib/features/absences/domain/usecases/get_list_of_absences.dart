import 'package:equatable/equatable.dart';

import '../../../../core/api/typedefs.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/absences_response.dart';
import '../enums/absence_type.dart';
import '../repositories/absences_repository.dart';

/// The [GetListOfAbsences] class is a use case that retrieves a list of absences
/// based on the specified absence type and date.
/// It extends the [UseCase] class and takes an [AbsencesRepository] as a dependency.
/// The [call] method is overridden to execute the use case and return the result.
/// The [GetAbsencesParams] class is used to pass parameters to the use case.
/// It contains properties such as [type], [date], and [pageInfo] to specify the
/// absence type, date, and pagination information.
///
class GetListOfAbsences extends UseCase<AbsencesResponse, GetAbsencesParams> {
  final AbsencesRepository repository;

  GetListOfAbsences({required this.repository});

  @override
  AppResult<AbsencesResponse> call(GetAbsencesParams params) async {
    return repository.getListOfAbsences(
      type: params.type,
      date: params.date,
      pageInfo: params.pageInfo,
    );
  }
}

class GetAbsencesParams extends Equatable {
  final AbsenceType? type;
  final DateTime? date;
  final PaginationParams pageInfo;

  const GetAbsencesParams({
    required this.type,
    required this.date,
    this.pageInfo = const PaginationParams(),
  });

  @override
  List<Object?> get props => [type, date, pageInfo];
}

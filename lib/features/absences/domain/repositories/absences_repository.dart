import 'package:crewmeister_coding_challenge/core/usecase/usecase.dart';

import '../../../../core/api/typedefs.dart';
import '../entities/absences_response.dart';
import '../enums/absence_type.dart';

/// The [AbsencesRepository] class is an abstract class that defines the contract
/// for a repository that handles absences.

abstract class AbsencesRepository {
  /// Retrieves a list of absences based on the specified absence type and date.
  /// The [type] parameter specifies the type of absence to retrieve.
  /// The [date] parameter specifies the date for which to retrieve absences.
  ///
  AppResult<AbsencesResponse> getListOfAbsences({
    required AbsenceType? type,
    required DateTime? date,
    PaginationParams pageInfo = const PaginationParams(),
  });
}

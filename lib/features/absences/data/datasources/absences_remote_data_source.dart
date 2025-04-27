import '../../../../core/api/api.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/enums/absence_type.dart';
import '../models/absence_model.dart';
import '../models/absences_response_model.dart';

abstract class AbsencesRemoteDataSource {
  /// Fetches a list of absences from the remote data source.
  ///
  /// The [type] parameter specifies the type of absence to retrieve.
  /// The [date] parameter specifies the date for which to retrieve absences.
  /// The [pageInfo] parameter specifies pagination information.
  ///
  /// Returns a [Future] that resolves to a list of absences.
  Future<AbsencesResponseModel> getListOfAbsences({
    required AbsenceType? type,
    required DateTime? date,
    PaginationParams pageInfo = const PaginationParams(),
  });
}

class AppAbsencesRemoteDataSource implements AbsencesRemoteDataSource {
  @override
  Future<AbsencesResponseModel> getListOfAbsences({
    required AbsenceType? type,
    required DateTime? date,
    PaginationParams pageInfo = const PaginationParams(),
  }) async {
    // Simulate a network call to fetch absences
    await Future.delayed(const Duration(seconds: 2));

    final absenceJson = await fetchListOfAbsences();
    final membersJson = await fetchListOfMembers();

    final absences = absenceJson
        .map(
          (absence) => AbsenceModel.fromJson(
            absence
              ..['member'] = membersJson.firstWhere(
                (member) => member['userId'] == absence['userId'],
              ),
          ),
        )
        .toList();

    // Filter absences based on the provided type
    // If type is null, it means we want all absences
    // If type is not null, we filter absences based on the type
    if (type != null) {
      absences.removeWhere((absence) => absence.type != type);
    }

    // Filter absences based on the provided date
    // If date is null, it means we want all absences
    // If date is not null, we filter absences based on the date
    // We check if the start date is before the provided date
    // and the end date is after the provided date
    // If the absence is not within the date range, we remove it
    // from the list of absences.
    if (date != null) {
      absences.removeWhere(
        (absence) =>
            (DateTime.tryParse(absence.startDate)?.isBefore(date) ?? true) ||
            (DateTime.tryParse(absence.endDate)?.isAfter(date) ?? true),
      );
    }

    // pagine list of absences based on pageInfo
    final paginatedAbsences = absences
        .skip((pageInfo.pageNo - 1) * pageInfo.pageSize)
        .take(pageInfo.pageSize)
        .toList();

    return AbsencesResponseModel(
      totalCount: absences.length,
      absences: paginatedAbsences,
    );
  }
}

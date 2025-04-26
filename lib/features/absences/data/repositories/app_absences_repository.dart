import '../../../../core/api/typedefs.dart';
import '../../../../core/errors/repository_call_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/absences_response.dart';
import '../../domain/enums/absence_type.dart';
import '../../domain/repositories/absences_repository.dart';
import '../datasources/absences_remote_data_source.dart';

class AppAbsencesRepository extends AbsencesRepository {
  final AbsencesRemoteDataSource remoteDataSource;
  final RepositoryCallHandler callHandler;

  AppAbsencesRepository({
    required this.remoteDataSource,
    required this.callHandler,
  });

  @override
  AppResult<AbsencesResponse> getListOfAbsences({
    required AbsenceType? type,
    required DateTime? date,
    PaginationParams pageInfo = const PaginationParams(),
  }) {
    return callHandler.handleCall<AbsencesResponse>(
      () => remoteDataSource.getListOfAbsences(
        type: type,
        date: date,
        pageInfo: pageInfo,
      ),
    );
  }
}

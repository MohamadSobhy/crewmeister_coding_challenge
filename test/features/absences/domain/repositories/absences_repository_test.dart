import 'package:crewmeister_coding_challenge/core/errors/exceptions.dart';
import 'package:crewmeister_coding_challenge/core/errors/failures.dart';
import 'package:crewmeister_coding_challenge/core/errors/repository_call_handler.dart';
import 'package:crewmeister_coding_challenge/core/network/network_info.dart';
import 'package:crewmeister_coding_challenge/core/usecase/usecase.dart';
import 'package:crewmeister_coding_challenge/features/absences/data/datasources/absences_remote_data_source.dart';
import 'package:crewmeister_coding_challenge/features/absences/data/models/absences_response_model.dart';
import 'package:crewmeister_coding_challenge/features/absences/data/repositories/app_absences_repository.dart';
import 'package:crewmeister_coding_challenge/features/absences/domain/enums/absence_type.dart';
import 'package:crewmeister_coding_challenge/features/absences/domain/repositories/absences_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mocks
class MockAbsencesRemoteDataSource extends Mock
    implements AbsencesRemoteDataSource {}

/// Fakes
class FakePaginationParams extends Fake implements PaginationParams {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Setup
  late MockAbsencesRemoteDataSource mockAbsencesRemoteDataSource;
  late RepositoryCallHandler callHandler;
  late NetworkInfo networkInfo;
  late AbsencesRepository sut;

  setUp(() {
    mockAbsencesRemoteDataSource = MockAbsencesRemoteDataSource();
    networkInfo = AppNetworkInfo();
    callHandler = RepositoryCallHandler(networkInfo: networkInfo);

    sut = AppAbsencesRepository(
      remoteDataSource: mockAbsencesRemoteDataSource,
      callHandler: callHandler,
    );

    registerFallbackValue(AbsenceType);
    registerFallbackValue(FakePaginationParams());
  });

  // Arrangements
  final tResponse = AbsencesResponseModel(totalCount: 0, absences: []);
  final tAbsenceType = AbsenceType.sickness;
  final tDate = DateTime.now();
  final tPageInfo = PaginationParams(pageNo: 1, pageSize: 10);

  void arrangeMockAbsencesRemoteDataSourceToReturnSuccessResponse() {
    when(
      () => mockAbsencesRemoteDataSource.getListOfAbsences(
        type: any(named: 'type'),
        date: any(named: 'date'),
        pageInfo: any(named: 'pageInfo'),
      ),
    ).thenAnswer((_) async => tResponse);
  }

  void arrangeMockAbsencesRemoteDataSourceToThrowAnException(
    Exception exception,
  ) {
    when(
      () => mockAbsencesRemoteDataSource.getListOfAbsences(
        type: any(named: 'type'),
        date: any(named: 'date'),
        pageInfo: any(named: 'pageInfo'),
      ),
    ).thenThrow(exception);
  }

  // Test case
  group(
    'getListOfAbsences',
    () {
      test(
        'should call the getListOfAbsences method from the repository',
        () async {
          // arrange
          arrangeMockAbsencesRemoteDataSourceToReturnSuccessResponse();

          // act
          await sut.getListOfAbsences(
            type: tAbsenceType,
            date: tDate,
            pageInfo: tPageInfo,
          );

          // assert
          verify(
            () => mockAbsencesRemoteDataSource.getListOfAbsences(
              type: tAbsenceType,
              date: tDate,
              pageInfo: tPageInfo,
            ),
          ).called(1);
        },
      );
    },
  );
  group(
    'GetListOfAbsences - Failure',
    () {
      test(
        'should return a failure when the remote data source fails',
        () async {
          // arrange
          const tException = ServerException(message: 'Server error');
          arrangeMockAbsencesRemoteDataSourceToThrowAnException(tException);

          // act
          final result = await sut.getListOfAbsences(
            type: tAbsenceType,
            date: tDate,
            pageInfo: tPageInfo,
          );

          // assert
          verify(
            () => mockAbsencesRemoteDataSource.getListOfAbsences(
              type: tAbsenceType,
              date: tDate,
              pageInfo: tPageInfo,
            ),
          ).called(1);
          expect(result, Left(ServerFailure(message: tException.message)));
        },
      );
    },
  );
  group(
    'GetListOfAbsences - Success',
    () {
      test(
        'should return a list of absences when the remote data source succeeds',
        () async {
          // arrange
          arrangeMockAbsencesRemoteDataSourceToReturnSuccessResponse();

          // act
          final result = await sut.getListOfAbsences(
            type: tAbsenceType,
            date: tDate,
            pageInfo: tPageInfo,
          );

          // assert
          verify(
            () => mockAbsencesRemoteDataSource.getListOfAbsences(
              type: tAbsenceType,
              date: tDate,
              pageInfo: tPageInfo,
            ),
          ).called(1);
          expect(result, Right(tResponse));
          verifyNoMoreInteractions(mockAbsencesRemoteDataSource);
        },
      );
    },
  );
}

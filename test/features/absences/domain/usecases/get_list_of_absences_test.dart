import 'package:crewmeister_coding_challenge/core/errors/failures.dart';
import 'package:crewmeister_coding_challenge/core/usecase/usecase.dart';
import 'package:crewmeister_coding_challenge/features/absences/data/models/absences_response_model.dart';
import 'package:crewmeister_coding_challenge/features/absences/domain/enums/absence_type.dart';
import 'package:crewmeister_coding_challenge/features/absences/domain/repositories/absences_repository.dart';
import 'package:crewmeister_coding_challenge/features/absences/domain/usecases/get_list_of_absences.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mocks
class MockAbsencesRepository extends Mock implements AbsencesRepository {}

/// Fakes
class FakePaginationParams extends Fake implements PaginationParams {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

// Setup
  late MockAbsencesRepository mockAbsencesRepository;
  late GetListOfAbsences usecase;

  setUp(() {
    mockAbsencesRepository = MockAbsencesRepository();
    usecase = GetListOfAbsences(repository: mockAbsencesRepository);

    registerFallbackValue(AbsenceType);
    registerFallbackValue(FakePaginationParams());
  });

  // Arrangements
  final tResponse = AbsencesResponseModel(totalCount: 0, absences: []);

  void arrangeMockAbsencesRepositoryToReturnSuccessResponse() {
    when(
      () => mockAbsencesRepository.getListOfAbsences(
        type: any(named: 'type'),
        date: any(named: 'date'),
        pageInfo: any(named: 'pageInfo'),
      ),
    ).thenAnswer(
      (_) async => Right(tResponse),
    );
  }

  void arrangeMockAbsencesRepositoryToReturnAFailure(Failure failure) {
    when(
      () => mockAbsencesRepository.getListOfAbsences(
        type: any(named: 'type'),
        date: any(named: 'date'),
        pageInfo: any(named: 'pageInfo'),
      ),
    ).thenAnswer((_) async => Left(failure));
  }

  // Test case
  group(
    'GetListOfAbsences',
    () {
      test(
        'should call the getListOfAbsences method from the repository',
        () async {
          // arrange
          const type = AbsenceType.sickness;
          final date = DateTime.now();
          const pageInfo = PaginationParams(pageNo: 1, pageSize: 10);
          arrangeMockAbsencesRepositoryToReturnSuccessResponse();

          // act
          await usecase(GetAbsencesParams(type: type, date: date));

          // assert
          verify(
            () => mockAbsencesRepository.getListOfAbsences(
              type: type,
              date: date,
              pageInfo: pageInfo,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockAbsencesRepository);
        },
      );
      test(
        'should get list of absences from the repository',
        () async {
          // Arrange
          const type = AbsenceType.sickness;
          final date = DateTime.now();
          const pageInfo = PaginationParams(pageNo: 1, pageSize: 10);
          arrangeMockAbsencesRepositoryToReturnSuccessResponse();

          // Act
          final result = await usecase(
            GetAbsencesParams(type: type, date: date, pageInfo: pageInfo),
          );

          // Assert
          verify(
            () => mockAbsencesRepository.getListOfAbsences(
              type: type,
              date: date,
              pageInfo: pageInfo,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockAbsencesRepository);
          expect(result, Right(tResponse));
        },
      );

      test(
        'should return a server failure when the repository fails',
        () async {
          // Arrange
          const type = AbsenceType.sickness;
          final date = DateTime.now();
          const pageInfo = PaginationParams(pageNo: 1, pageSize: 10);
          const failure = ServerFailure(message: 'Server Failure');
          arrangeMockAbsencesRepositoryToReturnAFailure(failure);

          // Act
          final result = await usecase(
            GetAbsencesParams(type: type, date: date, pageInfo: pageInfo),
          );

          // Assert
          verify(
            () => mockAbsencesRepository.getListOfAbsences(
              type: type,
              date: date,
              pageInfo: pageInfo,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockAbsencesRepository);
          expect(result, Left(failure));
        },
      );
    },
  );
}

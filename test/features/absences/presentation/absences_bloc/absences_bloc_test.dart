import 'package:crewmeister_coding_challenge/core/errors/failures.dart';
import 'package:crewmeister_coding_challenge/core/usecase/usecase.dart';
import 'package:crewmeister_coding_challenge/features/absences/data/models/absences_response_model.dart';
import 'package:crewmeister_coding_challenge/features/absences/domain/enums/absence_type.dart';
import 'package:crewmeister_coding_challenge/features/absences/domain/usecases/get_list_of_absences.dart';
import 'package:crewmeister_coding_challenge/features/absences/presentation/absences_bloc/absences_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockGetListOfAbsences extends Mock implements GetListOfAbsences {}

// Fake
class FakePaginationParams extends Fake implements PaginationParams {}

class FakeGetAbsencesParams extends Fake implements GetAbsencesParams {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Setup
  late MockGetListOfAbsences mockGetListOfAbsences;
  late AbsencesBloc sut;

  setUp(() {
    mockGetListOfAbsences = MockGetListOfAbsences();
    sut = AbsencesBloc(getListOfAbsences: mockGetListOfAbsences);

    registerFallbackValue(AbsenceType);
    registerFallbackValue(FakePaginationParams());
    registerFallbackValue(FakeGetAbsencesParams());
  });

  // Arrangements
  final tAbsenceType = AbsenceType.sickness;
  final tDate = DateTime.now();
  final tPageInfo = PaginationParams(pageNo: 1, pageSize: 10);
  final tAbsencesResponse = AbsencesResponseModel(totalCount: 0, absences: []);

  void arrangeMockGetListOfAbsencesToReturnSuccessResponse() {
    when(
      () => mockGetListOfAbsences(any<GetAbsencesParams>()),
    ).thenAnswer((_) async => Right(tAbsencesResponse));
  }

  void arrangeMockGetListOfAbsencesToReturnFailureResponse(Failure failure) {
    when(() => mockGetListOfAbsences(any<GetAbsencesParams>()))
        .thenAnswer((_) async => Left(failure));
  }

  // Test cases
  group(
    'AbsencesBloc',
    () {
      test(
        'initial state should be AbsencesInitialState',
        () async {
          // assert
          expectLater(sut.state, isA<AbsencesInitialState>());
        },
      );

      test(
        'should emit AbsencesLoadingState and then AbsencesFetchedState when getListOfAbsences is successful',
        () async {
          // arrange
          arrangeMockGetListOfAbsencesToReturnSuccessResponse();

          // assert later
          expectLater(
            sut.stream,
            emitsInOrder([
              isA<AbsencesLoadingState>(),
              isA<AbsencesFetchedState>(),
            ]),
          );

          // act
          sut.add(
            GetListOfAbsencesEvent(
              type: tAbsenceType,
              date: tDate,
              pageSize: tPageInfo.pageSize,
              paginate: false,
            ),
          );
        },
      );

      test(
        'should emit AbsencesNextPageLoadingState and then AbsencesFetchedState when getListOfAbsences is successful with pagination',
        () async {
          // arrange
          arrangeMockGetListOfAbsencesToReturnSuccessResponse();

          // assert later
          expectLater(
            sut.stream,
            emitsInOrder([
              isA<AbsencesNextPageLoadingState>(),
              isA<AbsencesFetchedState>(),
            ]),
          );

          // act
          sut.add(
            GetListOfAbsencesEvent(
              type: tAbsenceType,
              date: tDate,
              pageSize: tPageInfo.pageSize,
              paginate: true,
            ),
          );
        },
      );

      test(
        'should emit AbsencesLoadingState and then AbsencesErrorState when getListOfAbsences fails',
        () async {
          // arrange
          const failure = ServerFailure(message: 'Server Error');
          arrangeMockGetListOfAbsencesToReturnFailureResponse(failure);

          // assert later
          expectLater(
            sut.stream,
            emitsInOrder([
              isA<AbsencesLoadingState>(),
              isA<AbsencesErrorState>(),
            ]),
          );

          // act
          sut.add(
            GetListOfAbsencesEvent(
              type: tAbsenceType,
              date: tDate,
              pageSize: tPageInfo.pageSize,
              paginate: false,
            ),
          );
        },
      );
      test(
        'should emit AbsencesNextPageLoadingState and then AbsencesNextPageErrorState when getListOfAbsences fails with pagination',
        () async {
          // arrange
          const failure = ServerFailure(message: 'Server Error');
          arrangeMockGetListOfAbsencesToReturnFailureResponse(failure);

          // assert later
          expectLater(
            sut.stream,
            emitsInOrder([
              isA<AbsencesNextPageLoadingState>(),
              isA<AbsencesNextPageErrorState>(),
            ]),
          );

          // act
          sut.add(
            GetListOfAbsencesEvent(
              type: tAbsenceType,
              date: tDate,
              pageSize: tPageInfo.pageSize,
              paginate: true,
            ),
          );
        },
      );
    },
  );
}

import 'package:crewmeister_coding_challenge/app_module.dart';
import 'package:crewmeister_coding_challenge/app_widget.dart';
import 'package:crewmeister_coding_challenge/core/constants/constant_keys.dart';
import 'package:crewmeister_coding_challenge/core/errors/failures.dart';
import 'package:crewmeister_coding_challenge/core/theme/app_dimensions.dart';
import 'package:crewmeister_coding_challenge/core/theme/providers/app_themes_provider.dart';
import 'package:crewmeister_coding_challenge/core/theme/themes.dart';
import 'package:crewmeister_coding_challenge/core/usecase/usecase.dart';
import 'package:crewmeister_coding_challenge/core/widgets/app_toast/app_toast.dart';
import 'package:crewmeister_coding_challenge/core/widgets/app_toast/app_toast_view.dart';
import 'package:crewmeister_coding_challenge/features/absences/data/models/absence_model.dart';
import 'package:crewmeister_coding_challenge/features/absences/data/models/absences_response_model.dart';
import 'package:crewmeister_coding_challenge/features/absences/domain/enums/absence_type.dart';
import 'package:crewmeister_coding_challenge/features/absences/domain/usecases/get_list_of_absences.dart';
import 'package:crewmeister_coding_challenge/features/absences/presentation/absences_bloc/absences_bloc.dart';
import 'package:crewmeister_coding_challenge/features/absences/presentation/controllers/absences_filters_controller.dart';
import 'package:crewmeister_coding_challenge/features/absences/presentation/pages/absences_list_page.dart';
import 'package:crewmeister_coding_challenge/generated/l10n.dart';
import 'package:crewmeister_coding_challenge/injection_container.dart';
import 'package:crewmeister_coding_challenge/platform_app.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

// Mocks
class MockGetListOfAbsences extends Mock implements GetListOfAbsences {}

// Fake
class FakePaginationParams extends Fake implements PaginationParams {}

class FakeGetAbsencesParams extends Fake implements GetAbsencesParams {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// initialize service locator
  await initServiceLocator();

  /// Init App Colors and Styles
  AppModule.I
    ..useMaterial3 = true
    // Set the default Font Family for the app
    ..defaultFontFamily = 'Source Code Pro'
    // Set the secondary Font Family for the app
    ..secondaryFontFamily = 'Source Code Pro';

  // TODO: In case you need to change the app colors and styles, Do it like that and then refresh the state
  // ..setAppColors(MobileAppColors.instance)
  // ..setAppStyles(MobileAppStyles.instance)
  // ..setAppShadows(MobileAppShadows.instance)
  // ..setAppBorders(MobileAppBorders.instance);

  Provider.debugCheckInvalidValueType = null;

  // Setup
  late MockGetListOfAbsences mockGetListOfAbsences;
  late AbsencesBloc bloc;
  late AbsencesFiltersController controller;

  setUp(() {
    mockGetListOfAbsences = MockGetListOfAbsences();
    bloc = AbsencesBloc(getListOfAbsences: mockGetListOfAbsences);
    controller = AbsencesFiltersController();

    registerFallbackValue(AbsenceType);
    registerFallbackValue(FakePaginationParams());
    registerFallbackValue(FakeGetAbsencesParams());
  });

  // Arrangements
  final tAbsenceJson = {
    "admitterId": null,
    "admitterNote": "",
    "confirmedAt": "2020-12-12T18:03:55.000+01:00",
    "createdAt": "2020-12-12T14:17:01.000+01:00",
    "crewId": 352,
    "endDate": "2021-01-13",
    "id": 2351,
    "memberNote": "",
    "rejectedAt": null,
    "startDate": "2021-01-13",
    "type": "sickness",
    "userId": 2664,
    "member": {
      "crewId": 352,
      "id": 2650,
      "image": "https://loremflickr.com/300/400",
      "name": "Mike",
      "userId": 2664
    },
  };
  final tAbsenceType = AbsenceType.sickness;
  final tDate = DateTime.now();
  final tPageInfo = PaginationParams(pageNo: 1, pageSize: 10);
  final tAbsencesEmptyResponse =
      AbsencesResponseModel(totalCount: 0, absences: []);
  final tAbsencesResultResponse = AbsencesResponseModel(
    totalCount: 1,
    absences: [AbsenceModel.fromJson(tAbsenceJson)],
  );

  void arrangeMockGetListOfAbsencesToReturnEmptySuccessResponse() {
    when(
      () => mockGetListOfAbsences(any<GetAbsencesParams>()),
    ).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return Right(tAbsencesEmptyResponse);
    });
  }

  void arrangeMockGetListOfAbsencesToReturnResultSuccessResponse() {
    when(
      () => mockGetListOfAbsences(any<GetAbsencesParams>()),
    ).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return Right(tAbsencesResultResponse);
    });
  }

  void arrangeMockGetListOfAbsencesToReturnFailureResponse(Failure failure) {
    when(() => mockGetListOfAbsences(any<GetAbsencesParams>()))
        .thenAnswer((_) async => Left(failure));
  }

  /// CREATE createWidgetUnderTest() method to prepare the widget for test.
  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        Provider(create: (ctx) => bloc),
        ChangeNotifierProvider.value(value: controller),
      ],
      child: AppThemesProvider(
        scaffoldTheme: AppScaffoldTheme(
          backgroundGradientOpacity: 1,
          backgroundColor: AppModule.I.appColors.canvasColor,
        ),
        actionButtonTheme:
            AppModule.I.appStyles.defaultActionButtonTheme.copyWith(
          enableGradient: true,
          textStyle: AppModule.I.appStyles.text3(),
          borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
          borderColor: AppModule.I.appColors.primaryColor,
          disabledColor: AppModule.I.appColors.primaryColor.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.dimen_16),
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              MaterialApp(
                title: 'Crewmeister Coding Challenge',
                debugShowCheckedModeBanner: false,
                theme: AppModule.I.defaultTheme,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: const Locale('en', ''),
                scaffoldMessengerKey: AppModule.I.scaffoldMessengerKey,
                navigatorKey: AppModule.I.navigatorKey,
                home: AbsencesListPage(),
              ),
              StreamBuilder<AppToastData>(
                stream: AppModule.I.toastController.stream,
                builder: (context, snapshot) {
                  return snapshot.data?.message != null &&
                          snapshot.data!.message.trim().isNotEmpty
                      ? Positioned(
                          key: UniqueKey(),
                          bottom: defaultTargetPlatform == TargetPlatform.iOS
                              ? 40
                              : 20,
                          left: 0,
                          right: 0,
                          child: SafeArea(
                            child: AppToastView(toast: snapshot.data!),
                          ),
                        )
                      : const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Test cases
  group(
    'AbsencesBloc',
    () {
      testWidgets(
        'initial state should be showing an empty SizedBox()',
        (WidgetTester tester) async {
          // arrrange
          arrangeMockGetListOfAbsencesToReturnEmptySuccessResponse();
          await tester.pumpWidget(createWidgetUnderTest());

          // act
          await tester.pumpAndSettle();

          // assert
          expect(find.byKey(ConstantKeys.kInitialSizedBox), findsOneWidget);
        },
      );
      testWidgets(
        'should show loading indicator when loading',
        (WidgetTester tester) async {
          // arrange
          arrangeMockGetListOfAbsencesToReturnEmptySuccessResponse();
          await tester.pumpWidget(createWidgetUnderTest());

          // act
          bloc.add(GetListOfAbsencesEvent());
          await tester.pump(const Duration(seconds: 1));

          // assert
          expect(
            find.byKey(ConstantKeys.kLoadingIndicator),
            findsOneWidget,
          );
        },
      );
      testWidgets(
        'should show error view when failure occurs',
        (WidgetTester tester) async {
          // arrange
          const failure = ServerFailure(message: 'Server Failure');
          arrangeMockGetListOfAbsencesToReturnFailureResponse(failure);
          await tester.pumpWidget(createWidgetUnderTest());

          // act
          bloc.add(GetListOfAbsencesEvent());
          await tester.pumpAndSettle();

          // assert
          expect(find.byKey(ConstantKeys.kErrorView), findsOneWidget);
        },
      );

      testWidgets(
        'should show no data view when no data is available',
        (WidgetTester tester) async {
          // arrange
          arrangeMockGetListOfAbsencesToReturnEmptySuccessResponse();
          await tester.pumpWidget(createWidgetUnderTest());

          // act
          bloc.add(GetListOfAbsencesEvent());
          await tester.pumpAndSettle();

          // assert
          expect(find.byKey(ConstantKeys.kNoDataView), findsOneWidget);
        },
      );

      testWidgets(
        'should show absences list when data is available',
        (WidgetTester tester) async {
          // arrange
          arrangeMockGetListOfAbsencesToReturnResultSuccessResponse();
          await tester.pumpWidget(createWidgetUnderTest());

          // act
          bloc.add(GetListOfAbsencesEvent());
          await tester.pumpAndSettle();

          // assert
          expect(find.byKey(ConstantKeys.kAbsencesListView), findsOneWidget);
        },
      );
    },
  );
}

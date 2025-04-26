import 'dart:async';
import 'package:crewmeister_coding_challenge/features/absences/data/models/absences_response_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/absence.dart';
import '../../domain/usecases/get_list_of_absences.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/absences_response.dart';
import '../../domain/enums/absence_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'absences_event.dart';
part 'absences_state.dart';

class AbsencesBloc extends Bloc<AbsencesEvent, AbsencesState> {
  final GetListOfAbsences getListOfAbsences;

  AbsencesBloc({
    required this.getListOfAbsences,
  }) : super(AbsencesInitialState()) {
    on<AbsencesEvent>(_mapEventsIntoStates);
  }

  List<Absence> _absences = [];
  int _pageNo = 1;

  FutureOr<void> _mapEventsIntoStates(
    AbsencesEvent event,
    Emitter<AbsencesState> emit,
  ) async {
    if (event is GetListOfAbsencesEvent) {
      await _handleGetListOfAbsencesEvent(event, emit);
    }
  }

  Future<void> _handleGetListOfAbsencesEvent(
    GetListOfAbsencesEvent event,
    Emitter<AbsencesState> emit,
  ) async {
    if (event.paginate) {
      emit(AbsencesNextPageLoadingState());
    } else {
      emit(AbsencesLoadingState());
    }

    final result = await getListOfAbsences(
      GetAbsencesParams(
        type: event.type,
        date: event.date,
        pageInfo: PaginationParams(
          pageSize: event.pageSize,
          pageNo: _pageNo = event.paginate ? _pageNo + 1 : 1,
        ),
      ),
    );

    emit(
      result.fold(
        (failure) {
          if (event.paginate) {
            _pageNo--;
            return AbsencesNextPageErrorState(message: failure.message);
          }

          return AbsencesErrorState(message: failure.message);
        },
        (response) {
          /// If the response has less items than the page size, it means
          /// the last page has been reached, so we decrement the page number.
          /// so that the same page will be refetched next time to get the latest data
          /// in case new data is added.
          /// For example, if the page size is 10 and the response has 5 items,
          /// it means there are no more pages to fetch, so we decrement the page number.
          /// So when new record is added, the same page will be refetched to get the latest data
          /// which is 6 items this time. If we didn't decrement the page number,
          /// the next page will be fetched which is empty.
          /// So we need to decrement the page number to get the latest data.
          ///
          /// We can also check if the fetched absences length equals the total count
          /// then we can stop pagination. but i prefer keeping the logic to always check for
          /// new data when screen is scrolled.
          if (response.absences.length != event.pageSize) _pageNo--;

          /// If the event is paginated, we need to add the new absences to the existing list
          /// of absences. Otherwise, we need to replace the existing list with the new list.
          /// Then we can use the toSet() method to remove duplicates from the list.
          if (event.paginate) {
            _absences.addAll(response.absences);
          } else {
            _absences = response.absences;
          }

          return AbsencesFetchedState(
            response: AbsencesResponseModel(
              totalCount: response.totalCount,
              absences: _absences.toSet().toList(),
            ),
          );
        },
      ),
    );
  }
}

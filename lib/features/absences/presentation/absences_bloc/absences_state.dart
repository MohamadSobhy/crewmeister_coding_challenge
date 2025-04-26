part of 'absences_bloc.dart';

abstract class AbsencesState extends Equatable {
  const AbsencesState();

  @override
  List<Object?> get props => [];
}

class AbsencesInitialState extends AbsencesState {}

class AbsencesLoadingState extends AbsencesState {}

class AbsencesNextPageLoadingState extends AbsencesState {}

class AbsencesErrorState extends AbsencesState {
  final String message;

  const AbsencesErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class AbsencesNextPageErrorState extends AbsencesState {
  final String message;

  const AbsencesNextPageErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class AbsencesFetchedState extends AbsencesState {
  final AbsencesResponse response;

  const AbsencesFetchedState({required this.response});

  @override
  List<Object?> get props => [response];
}

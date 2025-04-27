import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_module.dart';
import '../../../../core/enums/app_toast_mode.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_listview.dart';
import '../../../../core/widgets/app_no_data_view.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_toast/app_toast.dart';
import '../../../../generated/l10n.dart';
import '../absences_bloc/absences_bloc.dart';
import '../controllers/absences_filters_controller.dart';
import '../widgets/absence_item_shimmer_loading_view.dart';
import '../widgets/absence_item_view.dart';
import '../widgets/absences_filters_icon.dart';

class AbsencesListPage extends StatelessWidget {
  static const String routeName = '/absences_list';

  const AbsencesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return AppScaffold(
      body: SafeArea(
        bottom: false,
        child: BlocConsumer<AbsencesBloc, AbsencesState>(
          listener: _onListeningToAbsencesBlocStates,
          buildWhen: (_, state) =>
              state is AbsencesLoadingState ||
              state is AbsencesErrorState ||
              state is AbsencesFetchedState,
          builder: (ctx, state) {
            if (state is AbsencesLoadingState) {
              return AbsenceListShimmerView();
            } else if (state is AbsencesErrorState) {
              return AppErrorView(
                message: state.message,
                onRefresh: () => refreshAbsencesList(context),
              );
            } else if (state is AbsencesFetchedState) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultSideMargin,
                  vertical: AppDimensions.smallSidePadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translations
                              .absencesCountFormat(state.response.totalCount),
                          style: AppModule.I.appStyles
                              .header4(
                                color: AppModule.I.appColors.primaryColor,
                              )
                              .copyWith(fontWeight: AppFontWeights.black),
                        ),
                        AbsencesFiltersIcon(),
                      ],
                    ),
                    Divider(color: AppModule.I.appColors.lightGrey),
                    Expanded(
                      child: state.response.absences.isEmpty
                          ? AppNoDataView(
                              message: translations.no_absences_msg,
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                refreshAbsencesList(context);
                              },
                              child: AppListView.builder(
                                physics: const BouncingScrollPhysics(),
                                allowPaginationHandling: true,
                                onPaginate: () {
                                  refreshAbsencesList(context, paginate: true);
                                },
                                padding: const EdgeInsets.only(
                                  bottom: AppDimensions.dimen_100,
                                ),
                                itemCount: state.response.absences.length,
                                itemBuilder: (context, index) {
                                  final absences = state.response.absences;

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      AbsenceItemView(absence: absences[index]),
                                      BlocBuilder<AbsencesBloc, AbsencesState>(
                                        builder: (context, pageState) {
                                          if (pageState
                                                  is AbsencesNextPageLoadingState &&
                                              index == absences.length - 1) {
                                            return AbsenceItemShimmerLoadingView();
                                          }

                                          return SizedBox();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _onListeningToAbsencesBlocStates(
    BuildContext ctx,
    AbsencesState state,
  ) {
    if (state is AbsencesNextPageErrorState) {
      AppToast.I.showToast(state.message, mode: AppToastMode.error);
    }
  }

  static void refreshAbsencesList(
    BuildContext context, {
    bool paginate = false,
  }) {
    final bloc = context.read<AbsencesBloc>();
    final filtersController = context.read<AbsencesFiltersController>();

    log('Fetchiing absences list with filters: ');
    log('Selected absence type: ${filtersController.selectedAbsenceType}');
    log('Selected date: ${filtersController.selectedDate}');
    log('Paginate: $paginate');

    bloc.add(
      GetListOfAbsencesEvent(
        type: filtersController.selectedAbsenceType,
        date: DateTime.tryParse(filtersController.selectedDate ?? ''),
        paginate: paginate,
      ),
    );
  }
}

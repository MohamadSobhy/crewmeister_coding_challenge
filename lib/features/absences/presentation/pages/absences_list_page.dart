import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_module.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_listview.dart';
import '../../../../core/widgets/app_loading_view.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../absences_bloc/absences_bloc.dart';
import '../widgets/absence_item_shimmer_loading_view.dart';
import '../widgets/absence_item_view.dart';

class AbsencesListPage extends StatelessWidget {
  static const String routeName = '/absences_list';

  const AbsencesListPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              return AppErrorView(message: state.message);
            } else if (state is AbsencesFetchedState) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultSideMargin,
                  vertical: AppDimensions.smallSidePadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Absences (${state.response.totalCount})',
                      style: AppModule.I.appStyles
                          .header4(
                            color: AppModule.I.appColors.primaryColor,
                          )
                          .copyWith(fontWeight: AppFontWeights.black),
                    ),
                    Divider(color: AppModule.I.appColors.lightGrey),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          final bloc = context.read<AbsencesBloc>();
                          bloc.add(GetListOfAbsencesEvent());
                        },
                        child: AppListView.builder(
                          physics: const BouncingScrollPhysics(),
                          allowPaginationHandling: true,
                          onPaginate: () {
                            final bloc = context.read<AbsencesBloc>();
                            bloc.add(GetListOfAbsencesEvent(paginate: true));
                          },
                          padding: const EdgeInsets.only(
                            bottom: AppDimensions.dimen_100,
                          ),
                          itemCount: state.response.absences.length,
                          itemBuilder: (context, index) {
                            final absences = state.response.absences;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
  ) {}
}

import 'package:flutter/material.dart';

import '../../../../core/widgets/app_scaffold.dart';

class AbsencesListPage extends StatelessWidget {
  static const String routeName = '/absences_list';

  const AbsencesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Absences List Page'),
          ],
        ),
      ),
    );
  }
}

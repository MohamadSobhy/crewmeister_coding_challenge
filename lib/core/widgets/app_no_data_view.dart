import 'package:flutter/material.dart';

import '../../app_module.dart';
import '../theme/app_dimensions.dart';

class AppNoDataView extends StatelessWidget {
  final String message;

  const AppNoDataView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.dimen_28),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.insert_drive_file_outlined,
              color: AppModule.I.appColors.primaryColor,
              size: 50,
            ),
            const SizedBox(height: AppDimensions.dimen_10),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

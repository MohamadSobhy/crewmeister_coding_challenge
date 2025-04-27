import 'package:flutter/material.dart';

import '../theme/app_dimensions.dart';

class AppErrorView extends StatelessWidget {
  final String message;

  const AppErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.dimen_28),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
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

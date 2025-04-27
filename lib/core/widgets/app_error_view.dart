import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../theme/app_dimensions.dart';
import 'app_action_button.dart';

class AppErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRefresh;

  const AppErrorView({super.key, required this.message, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

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
            if (onRefresh != null) ...[
              const SizedBox(height: AppDimensions.dimen_20),
              AppActionButton.submit(
                text: translations.refresh,
                onPressed: onRefresh,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

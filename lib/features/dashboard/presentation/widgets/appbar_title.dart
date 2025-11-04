import 'package:budgeetme/core/theme/app_font.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCollapsed = constraints.maxHeight < 80;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isCollapsed
              ? Text(
                  'BudgeetMe',
                  key: const ValueKey('title'),
                  style: AppFont.headlineSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Column(
                  key: const ValueKey('both'),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'BudgeetMe',
                      style: AppFont.headlineSmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Kelola keuangan Anda',
                      style: AppFont.bodySmall.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

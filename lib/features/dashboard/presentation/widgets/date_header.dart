import 'package:budgeetme/core/theme/theme.dart';
import 'package:flutter/material.dart';

class DateHeader extends StatelessWidget {
  const DateHeader({
    required this.dateLabel,
    required this.isExpanded,
    required this.onTap,
    super.key,
  });

  final String dateLabel;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Material(
      color: colorScheme.surface,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              AnimatedRotation(
                turns: isExpanded ? 0.25 : 0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurface.withValues(
                    alpha: 0.6,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  dateLabel,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: AppFont.bold,
                    color: Theme.of(context).colorScheme.onSurface.withValues(
                      alpha: 0.7,
                    ),
                  ),
                ),
              ),
              Icon(
                isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

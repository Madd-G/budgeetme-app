import 'package:budgeetme/core/theme/theme.dart';
import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  const FilterChipWidget({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
    this.color,
    super.key,
  });

  final String label;
  final IconData? icon;
  final Color? color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.colorScheme.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? effectiveColor.withValues(alpha: 0.15)
              : context.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? effectiveColor
                : context.colorScheme.outline.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: isSelected
                    ? effectiveColor
                    : context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: AppFont.labelLarge.copyWith(
                color: isSelected
                    ? effectiveColor
                    : context.colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: isSelected ? AppFont.bold : AppFont.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

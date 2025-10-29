import 'package:budgeetme/core/theme/theme.dart';
import 'package:budgeetme/core/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({
    required this.selectedDate,
    required this.isEnabled,
    required this.onDateSelected,
    super.key,
  });

  final DateTime selectedDate;
  final bool isEnabled;
  final Function(DateTime) onDateSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tanggal',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: AppFont.semiBold,
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: isEnabled ? () => _pickDate(context) : null,
          borderRadius: BorderRadius.circular(14),
          child: Opacity(
            opacity: isEnabled ? 1.0 : 0.5,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.calendar_today_rounded,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      selectedDate.toIndonesianLongFormat(),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: AppFont.semiBold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      onDateSelected(DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      ));
    }
  }
}

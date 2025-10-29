import 'package:budgeetme/core/theme/theme.dart';
import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Catatan (Opsional)',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: AppFont.semiBold,
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Tambahkan catatan',
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Icon(
                Icons.notes_rounded,
                color: theme.colorScheme.primary,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minHeight: 0,
              minWidth: 40,
            ),
          ),
          minLines: 3,
          maxLines: 5,
          maxLength: 200,
        ),
      ],
    );
  }
}

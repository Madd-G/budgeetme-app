import 'package:budgeetme/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    required this.categories,
    required this.selectedCategory,
    required this.isEnabled,
    required this.onCategoryChanged,
    super.key,
  });

  final List<String> categories;
  final String selectedCategory;
  final bool isEnabled;
  final Function(String) onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategori',
          style: AppFont.titleSmall.copyWith(
            fontWeight: AppFont.semiBold,
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: selectedCategory,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.category_rounded,
              color: colorScheme.primary,
            ),
          ),
          items: categories
              .map(
                (category) =>
                    DropdownMenuItem(value: category, child: Text(category)),
              )
              .toList(),
          onChanged: isEnabled
              ? (value) {
                  if (value != null) {
                    onCategoryChanged(value);
                  }
                }
              : null,
        ),
      ],
    );
  }
}

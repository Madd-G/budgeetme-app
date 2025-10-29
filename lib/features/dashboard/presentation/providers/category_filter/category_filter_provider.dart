import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_filter_provider.g.dart';

@riverpod
class CategoryFilter extends _$CategoryFilter {
  @override
  int? build() => null;

  void selectCategory(int? categoryId) {
    state = categoryId;
  }

  void clearFilter() {
    state = null;
  }
}

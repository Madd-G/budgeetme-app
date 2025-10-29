import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expanded_days_provider.g.dart';

@riverpod
class ExpandedDays extends _$ExpandedDays {
  bool _initialized = false;

  @override
  Set<String> build() => {};

  void initializeIfNeeded(List<String> dateLabels) {
    if (!_initialized && dateLabels.isNotEmpty) {
      _initialized = true;
      state = {...dateLabels};
    }
  }

  void toggle(String dateLabel) {
    if (state.contains(dateLabel)) {
      state = {...state}..remove(dateLabel);
    } else {
      state = {...state, dateLabel};
    }
  }

  bool isExpanded(String dateLabel) => state.contains(dateLabel);

  void expandAll(List<String> dateLabels) {
    state = {...dateLabels};
  }

  void collapseAll() {
    state = {};
  }
}

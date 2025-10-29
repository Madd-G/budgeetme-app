class TransactionFilter {
  const TransactionFilter({this.categoryId});

  final int? categoryId;

  static const empty = TransactionFilter();

  TransactionFilter copyWith({
    int? categoryId,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return TransactionFilter(categoryId: categoryId ?? this.categoryId);
  }

  bool get hasFilter => categoryId != null;
}

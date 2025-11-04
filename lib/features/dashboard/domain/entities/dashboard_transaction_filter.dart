class DashboardTransactionFilter {
  const DashboardTransactionFilter({this.categoryId});

  final int? categoryId;

  static const empty = DashboardTransactionFilter();

  DashboardTransactionFilter copyWith({int? categoryId}) {
    return DashboardTransactionFilter(
      categoryId: categoryId ?? this.categoryId,
    );
  }
}

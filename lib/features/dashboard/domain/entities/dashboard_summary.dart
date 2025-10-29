class DashboardSummary {
  const DashboardSummary({
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
  });

  final double totalIncome;
  final double totalExpense;
  final double balance;

  static const empty = DashboardSummary(
    totalIncome: 0,
    totalExpense: 0,
    balance: 0,
  );

  DashboardSummary copyWith({
    double? totalIncome,
    double? totalExpense,
    double? balance,
    int? transactionCount,
  }) {
    return DashboardSummary(
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      balance: balance ?? this.balance,
    );
  }
}

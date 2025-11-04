class DashboardTransactionSummary {
  const DashboardTransactionSummary({
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
  });

  final double totalIncome;
  final double totalExpense;
  final double balance;

  DashboardTransactionSummary copyWith({
    double? totalIncome,
    double? totalExpense,
    double? balance,
  }) {
    return DashboardTransactionSummary(
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      balance: balance ?? this.balance,
    );
  }

  static final empty = DashboardTransactionSummary(
    totalIncome: 0,
    totalExpense: 0,
    balance: 0,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DashboardTransactionSummary &&
        other.totalIncome == totalIncome &&
        other.totalExpense == totalExpense &&
        other.balance == balance;
  }

  @override
  int get hashCode =>
      totalIncome.hashCode ^ totalExpense.hashCode ^ balance.hashCode;

  @override
  String toString() {
    return 'DashboardTransactionSummary('
        'totalIncome: \$${totalIncome.toStringAsFixed(2)}, '
        'totalExpense: \$${totalExpense.toStringAsFixed(2)}, '
        'balance: \$${balance.toStringAsFixed(2)}'
        ')';
  }
}

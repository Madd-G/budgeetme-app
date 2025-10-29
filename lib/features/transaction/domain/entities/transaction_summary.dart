class TransactionSummary {
  const TransactionSummary({
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
  });

  final double totalIncome;
  final double totalExpense;
  final double balance;

  TransactionSummary copyWith({
    double? totalIncome,
    double? totalExpense,
    double? balance,
  }) {
    return TransactionSummary(
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      balance: balance ?? this.balance,
    );
  }

  static final empty = TransactionSummary(
    totalIncome: 0,
    totalExpense: 0,
    balance: 0,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionSummary &&
        other.totalIncome == totalIncome &&
        other.totalExpense == totalExpense &&
        other.balance == balance;
  }

  @override
  int get hashCode =>
      totalIncome.hashCode ^ totalExpense.hashCode ^ balance.hashCode;

  @override
  String toString() {
    return 'TransactionSummary('
        'totalIncome: \$${totalIncome.toStringAsFixed(2)}, '
        'totalExpense: \$${totalExpense.toStringAsFixed(2)}, '
        'balance: \$${balance.toStringAsFixed(2)}';
  }
}

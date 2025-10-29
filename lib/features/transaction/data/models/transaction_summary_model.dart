import 'package:budgeetme/features/transaction/domain/entities/transaction_summary.dart';

class TransactionSummaryModel {
  const TransactionSummaryModel({
    required this.balance,
    required this.income,
    required this.expenses,
    this.categoryId,
    this.categoryName,
  });

  final double balance;
  final double income;
  final double expenses;
  final int? categoryId;
  final String? categoryName;

  factory TransactionSummaryModel.fromJson(Map<String, dynamic> json) {
    return TransactionSummaryModel(
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      income: (json['income'] as num?)?.toDouble() ?? 0.0,
      expenses: (json['expenses'] as num?)?.toDouble() ?? 0.0,
      categoryId: json['categoryId'] as int?,
      categoryName: json['categoryName'] as String?,
    );
  }

  TransactionSummary toEntity() {
    return TransactionSummary(
      balance: balance,
      totalIncome: income,
      totalExpense: expenses,
    );
  }
}

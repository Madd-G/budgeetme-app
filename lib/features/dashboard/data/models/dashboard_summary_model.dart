import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_summary.dart';

class DashboardSummaryModel {
  const DashboardSummaryModel({
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

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    return DashboardSummaryModel(
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      income: (json['income'] as num?)?.toDouble() ?? 0.0,
      expenses: (json['expenses'] as num?)?.toDouble() ?? 0.0,
      categoryId: json['categoryId'] as int?,
      categoryName: json['categoryName'] as String?,
    );
  }

  DashboardTransactionSummary toEntity() {
    return DashboardTransactionSummary(
      balance: balance,
      totalIncome: income,
      totalExpense: expenses,
    );
  }
}

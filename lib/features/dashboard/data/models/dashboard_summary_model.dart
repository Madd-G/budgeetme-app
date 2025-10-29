import 'package:budgeetme/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:budgeetme/features/transaction/data/models/transaction_summary_model.dart';

class DashboardSummaryModel {
  const DashboardSummaryModel({
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
  });

  final double totalIncome;
  final double totalExpense;
  final double balance;

  factory DashboardSummaryModel.fromTransactionSummary(
    TransactionSummaryModel transactionSummary,
  ) {
    return DashboardSummaryModel(
      totalIncome: transactionSummary.income,
      totalExpense: transactionSummary.expenses,
      balance: transactionSummary.balance,
    );
  }

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    return DashboardSummaryModel(
      totalIncome: (json['totalIncome'] as num?)?.toDouble() ?? 0.0,
      totalExpense: (json['totalExpense'] as num?)?.toDouble() ?? 0.0,
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    );
  }

  DashboardSummary toEntity() {
    return DashboardSummary(
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      balance: balance,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'balance': balance,
    };
  }
}

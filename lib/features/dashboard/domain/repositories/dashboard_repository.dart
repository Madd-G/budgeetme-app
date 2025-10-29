import 'package:budgeetme/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:budgeetme/features/dashboard/domain/entities/transaction_filter.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';

abstract class DashboardRepository {
  Future<DashboardSummary> fetchSummary({TransactionFilter? filter});

  Future<List<Transaction>> fetchTransactions({TransactionFilter? filter});

  Future<DashboardSummary> fetchCategorySummary(int categoryId);
}

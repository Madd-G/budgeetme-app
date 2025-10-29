import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:budgeetme/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:budgeetme/features/transaction/data/datasources/transaction_remote_datasource.dart';
import 'package:budgeetme/features/transaction/data/models/transaction_model.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction_summary.dart';
import 'package:budgeetme/features/transaction/domain/repositories/transaction_repository.dart';

part 'transaction_repository_impl.g.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl(
    this._transactionDataSource,
    this._dashboardDataSource,
  );

  final TransactionRemoteDataSource _transactionDataSource;
  final DashboardRemoteDataSource _dashboardDataSource;

  @override
  Future<Transaction> createTransaction(Transaction transaction) async {
    final request = TransactionRequestModel.fromTransaction(transaction);
    final id = await _transactionDataSource.createTransaction(request);
    final detail = await _dashboardDataSource.fetchTransactionDetail(id);

    return detail.toEntity();
  }

  @override
  Future<void> deleteTransaction(int id) {
    return _transactionDataSource.deleteTransaction(id);
  }

  @override
  Future<List<Transaction>> fetchTransactions() async {
    final data = await _dashboardDataSource.fetchTransactions();
    return data.map((d) => d.toEntity()).toList();
  }

  @override
  Future<Transaction> updateTransaction(Transaction transaction) async {
    final request = TransactionRequestModel.fromTransaction(transaction);
    await _transactionDataSource.updateTransaction(
      id: transaction.id,
      request: request,
    );
    final detail = await _dashboardDataSource.fetchTransactionDetail(
      transaction.id,
    );

    return detail.toEntity();
  }

  @override
  TransactionSummary buildSummary(List<Transaction> transactions) {
    final income = transactions
        .where((transaction) => transaction.isIncome)
        .fold<double>(0, (prev, transaction) => prev + transaction.amount);
    final expense = transactions
        .where((transaction) => !transaction.isIncome)
        .fold<double>(0, (prev, transaction) => prev + transaction.amount);
    return TransactionSummary(
      totalIncome: income,
      totalExpense: expense,
      balance: income - expense,
    );
  }
}

@Riverpod(keepAlive: true)
TransactionRepository transactionRepository(Ref ref) {
  final transactionDataSource = ref.watch(transactionRemoteDataSourceProvider);
  final dashboardDataSource = ref.watch(dashboardRemoteDataSourceProvider);
  return TransactionRepositoryImpl(transactionDataSource, dashboardDataSource);
}

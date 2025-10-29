import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction_summary.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> fetchTransactions();

  Future<Transaction> createTransaction(Transaction transaction);

  Future<Transaction> updateTransaction(Transaction transaction);

  Future<void> deleteTransaction(int id);

  TransactionSummary buildSummary(List<Transaction> transactions);
}

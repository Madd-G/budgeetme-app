import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<Transaction> createTransaction(Transaction transaction);

  Future<Transaction> updateTransaction(Transaction transaction);

  Future<void> deleteTransaction(int id);
}

import 'package:budgeetme/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';
import 'package:budgeetme/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manage_transaction_usecase.g.dart';

class ManageTransactionUseCase {
  const ManageTransactionUseCase(this._repository);

  final TransactionRepository _repository;

  Future<Transaction> create(Transaction transaction) {
    return _repository.createTransaction(transaction);
  }

  Future<Transaction> update(Transaction transaction) {
    return _repository.updateTransaction(transaction);
  }

  Future<void> delete(int id) {
    return _repository.deleteTransaction(id);
  }
}

@riverpod
ManageTransactionUseCase manageTransactionUseCase(Ref ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return ManageTransactionUseCase(repository);
}

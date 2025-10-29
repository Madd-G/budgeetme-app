import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';
import 'package:budgeetme/features/transaction/domain/usecases/manage_transaction/manage_transaction_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_manage_provider.g.dart';

@Riverpod(keepAlive: true)
class TransactionManage extends _$TransactionManage {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> create(Transaction transaction) async {
    if (!ref.mounted) return;
    state = const AsyncLoading();
    try {
      final useCase = ref.read(manageTransactionUseCaseProvider);
      await useCase.create(transaction);
      if (!ref.mounted) return;
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      if (ref.mounted) state = AsyncError(error, stackTrace);
    }
  }

  Future<void> update(Transaction transaction) async {
    if (!ref.mounted) return;
    state = const AsyncLoading();
    try {
      final useCase = ref.read(manageTransactionUseCaseProvider);
      await useCase.update(transaction);
      if (!ref.mounted) return;
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      if (ref.mounted) state = AsyncError(error, stackTrace);
    }
  }

  Future<void> delete(int id) async {
    if (!ref.mounted) return;
    state = const AsyncLoading();
    try {
      final useCase = ref.read(manageTransactionUseCaseProvider);
      await useCase.delete(id);
      if (!ref.mounted) return;
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      if (ref.mounted) state = AsyncError(error, stackTrace);
    }
  }
}

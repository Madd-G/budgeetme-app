import 'package:budgeetme/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:budgeetme/features/dashboard/domain/entities/paginated_transactions.dart';
import 'package:budgeetme/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_transactions_usecase.g.dart';

@riverpod
FetchTransactionsUseCase fetchTransactionsUseCase(Ref ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return FetchTransactionsUseCase(repository);
}

class FetchTransactionsUseCase {
  const FetchTransactionsUseCase(this._repository);

  final DashboardRepository _repository;

  Future<PaginatedTransactions> execute({
    required int page,
    int? categoryId,
  }) async {
    return await _repository.fetchTransactions(
      page: page,
      categoryId: categoryId,
    );
  }
}

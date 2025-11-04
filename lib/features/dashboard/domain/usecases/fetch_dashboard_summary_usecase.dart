import 'package:budgeetme/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_summary.dart';
import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_filter.dart';
import 'package:budgeetme/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_dashboard_summary_usecase.g.dart';

@riverpod
FetchDashboardSummaryUseCase fetchDashboardSummaryUseCase(Ref ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return FetchDashboardSummaryUseCase(repository);
}

class FetchDashboardSummaryUseCase {
  const FetchDashboardSummaryUseCase(this._repository);

  final DashboardRepository _repository;

  Future<DashboardTransactionSummary> execute({
    DashboardTransactionFilter? filter,
  }) async {
    try {
      if (filter?.categoryId != null) {
        return await _repository.fetchCategorySummary(filter!.categoryId!);
      }
      return await _repository.fetchSummary(filter: filter);
    } catch (error) {
      return DashboardTransactionSummary.empty;
    }
  }
}

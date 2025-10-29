import 'package:budgeetme/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:budgeetme/features/dashboard/domain/entities/transaction_filter.dart';
import 'package:budgeetme/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_dashboard_summary_usecase.g.dart';

@riverpod
FetchDashboardSummaryUseCase fetchDashboardSummaryUseCase(Ref ref) {
  throw UnimplementedError('Provider must be overridden');
}

class FetchDashboardSummaryUseCase {
  const FetchDashboardSummaryUseCase(this._repository);

  final DashboardRepository _repository;

  Future<DashboardSummary> execute({TransactionFilter? filter}) async {
    try {
      if (filter?.categoryId != null) {
        return await _repository.fetchCategorySummary(filter!.categoryId!);
      }
      return await _repository.fetchSummary(filter: filter);
    } catch (error) {
      return DashboardSummary.empty;
    }
  }
}

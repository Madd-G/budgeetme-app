import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_filter.dart';
import 'package:budgeetme/features/dashboard/domain/usecases/fetch_dashboard_summary_usecase.dart';
import 'package:budgeetme/features/dashboard/presentation/providers/category_filter/category_filter_provider.dart';
import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_summary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_summary_provider.g.dart';

@riverpod
Future<DashboardTransactionSummary> transactionSummary(Ref ref) async {
  final useCase = ref.watch(fetchDashboardSummaryUseCaseProvider);
  final categoryId = ref.watch(categoryFilterProvider);

  final filter = categoryId != null
      ? DashboardTransactionFilter(categoryId: categoryId)
      : null;

  return await useCase.execute(filter: filter);
}

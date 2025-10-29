import 'package:budgeetme/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:budgeetme/features/dashboard/presentation/providers/category_filter/category_filter_provider.dart';
import 'package:budgeetme/features/dashboard/presentation/providers/transaction_summary/transaction_summary_provider.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_list_provider.g.dart';

@Riverpod(keepAlive: true)
class TransactionList extends _$TransactionList {
  int _currentPage = 1;
  bool _hasMore = true;
  List<Transaction> _allTransactions = [];

  @override
  Future<List<Transaction>> build() async {
    _currentPage = 1;
    _hasMore = true;
    _allTransactions = [];

    return _loadPage(1);
  }

  Future<List<Transaction>> _loadPage(int page) async {
    final categoryId = ref.watch(categoryFilterProvider);
    final dataSource = ref.watch(dashboardRemoteDataSourceProvider);

    if (categoryId != null) {
      final remotes = await dataSource.fetchTransactionsByCategory(
        categoryId: categoryId,
        page: page,
      );
      final transactions = remotes.map((r) => r.toEntity()).toList();

      if (page == 1) {
        _allTransactions = transactions;
      } else {
        _allTransactions.addAll(transactions);
      }

      _hasMore = transactions.length >= 10;
      _currentPage = page;

      return List.from(_allTransactions);
    } else {
      final remotes = await dataSource.fetchTransactions(page: page);
      final transactions = remotes.map((r) => r.toEntity()).toList();

      if (page == 1) {
        _allTransactions = transactions;
      } else {
        _allTransactions.addAll(transactions);
      }

      _hasMore = transactions.length >= 10;
      _currentPage = page;

      return List.from(_allTransactions);
    }
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    final nextPage = _currentPage + 1;
    state = await AsyncValue.guard(() => _loadPage(nextPage));
  }

  Future<void> refresh() async {
    _currentPage = 1;
    _hasMore = true;
    _allTransactions = [];
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadPage(1));

    ref.invalidate(transactionSummaryProvider);
  }

  bool get hasMore => _hasMore;

  void removeById(int id) {
    _allTransactions.removeWhere((t) => t.id == id);
    state = AsyncData(List<Transaction>.from(_allTransactions));

    ref.invalidate(transactionSummaryProvider);
  }
}

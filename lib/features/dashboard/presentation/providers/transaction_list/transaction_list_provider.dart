import 'package:budgeetme/features/dashboard/domain/usecases/fetch_transactions_usecase.dart';
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
  bool _isLoadingMore = false;

  @override
  Future<List<Transaction>> build() async {

    ref.watch(categoryFilterProvider);

    _currentPage = 1;
    _hasMore = true;
    _allTransactions = [];
    _isLoadingMore = false;

    return _loadPage(1);
  }

  Future<List<Transaction>> _loadPage(int page) async {
    final categoryId = ref.read(categoryFilterProvider);
    final useCase = ref.read(fetchTransactionsUseCaseProvider);

    final response = await useCase.execute(
      page: page,
      categoryId: categoryId,
    );

    if (page == 1) {
      _allTransactions = response.data;
    } else {
      _allTransactions.addAll(response.data);
    }

    _hasMore = response.hasMore;
    _currentPage = page;

    return List.from(_allTransactions);
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading || _isLoadingMore) return;

    _isLoadingMore = true;
    try {
      final nextPage = _currentPage + 1;
      state = await AsyncValue.guard(() => _loadPage(nextPage));
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> refresh() async {
    _currentPage = 1;
    _hasMore = true;
    _allTransactions = [];
    _isLoadingMore = false;
    
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

import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';

class PaginatedTransactions {
  const PaginatedTransactions({
    required this.data,
    required this.total,
    required this.totalPages,
    required this.currentPage,
    required this.perPage,
    this.categoryId,
  });

  final List<Transaction> data;
  final int total;
  final int totalPages;
  final int currentPage;
  final int perPage;
  final int? categoryId;

  bool get hasMore => currentPage < totalPages;
}

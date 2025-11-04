import 'package:budgeetme/features/transaction/data/models/transaction_model.dart';

class TransactionPaginatedResponse {
  const TransactionPaginatedResponse({
    required this.data,
    required this.total,
    required this.totalPages,
    required this.currentPage,
    required this.perPage,
    this.categoryId,
  });

  final List<TransactionModel> data;
  final int total;
  final int totalPages;
  final int currentPage;
  final int perPage;
  final int? categoryId;

  bool get hasMore => currentPage < totalPages;

  factory TransactionPaginatedResponse.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>? ?? <dynamic>[];
    final transactions = dataList
        .whereType<Map<String, dynamic>>()
        .map(TransactionModel.fromJson)
        .toList();

    return TransactionPaginatedResponse(
      data: transactions,
      total: json['total'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
      currentPage: json['currentPage'] as int? ?? 1,
      perPage: json['perPage'] as int? ?? 10,
      categoryId: json['categoryId'] as int?,
    );
  }

  @override
  String toString() {
    return 'TransactionPaginatedResponse('
        'total: $total, '
        'totalPages: $totalPages, '
        'currentPage: $currentPage, '
        'perPage: $perPage, '
        'categoryId: $categoryId, '
        'dataCount: ${data.length})';
  }
}

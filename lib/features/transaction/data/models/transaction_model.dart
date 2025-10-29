import 'package:budgeetme/core/extensions/date_time_extensions.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction_type.dart';

class TransactionModel {
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as int,
      transactionDate: json['transactionDate'] as String,
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName'] as String,
      amount: _doubleFromJson(json['amount']),
      note: json['note'] as String?,
    );
  }

  const TransactionModel({
    required this.id,
    required this.transactionDate,
    required this.categoryId,
    required this.categoryName,
    required this.amount,
    this.note,
  });

  final int id;
  final String transactionDate;
  final int categoryId;
  final String categoryName;
  final double amount;
  final String? note;

  Transaction toEntity() {
    final type = categoryId == 1
        ? TransactionType.income
        : TransactionType.expense;

    final parsedDate = transactionDate.parseTransactionDate() ?? DateTime.now();

    return Transaction(
      id: id,
      amount: amount,
      type: type,
      category: categoryName,
      description: note,
      date: parsedDate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionModel &&
        other.id == id &&
        other.transactionDate == transactionDate &&
        other.categoryId == categoryId &&
        other.categoryName == categoryName &&
        other.amount == amount &&
        other.note == note;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      transactionDate.hashCode ^
      categoryId.hashCode ^
      categoryName.hashCode ^
      amount.hashCode ^
      note.hashCode;

  @override
  String toString() {
    return 'TransactionModel('
        'id: $id, '
        'transactionDate: $transactionDate, '
        'categoryId: $categoryId, '
        'categoryName: $categoryName, '
        'amount: $amount, '
        'note: $note)';
  }
}

double _doubleFromJson(Object? value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value) ?? 0;
  }
  return 0;
}

class TransactionRequestModel {
  factory TransactionRequestModel.fromTransaction(Transaction transaction) {
    final categoryId = transaction.type == TransactionType.income ? 1 : 2;
    return TransactionRequestModel(
      transactionDate: transaction.date,
      categoryId: categoryId,
      amount: transaction.amount,
      note: transaction.description,
    );
  }

  TransactionRequestModel({
    required this.transactionDate,
    required this.categoryId,
    required this.amount,
    this.note,
  });

  final DateTime transactionDate;
  final int categoryId;
  final double amount;
  final String? note;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'transaction_date': transactionDate.toApiFormat(),
      'category_id': categoryId,
      'amount': amount,
      'note': note,
    }..removeWhere((_, value) => value == null);
  }
}

import 'package:budgeetme/features/transaction/domain/entities/transaction_type.dart';

class Transaction {
  const Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.description,
  });

  final int id;
  final double amount;
  final TransactionType type;
  final String category;
  final String? description;
  final DateTime date;

  Transaction copyWith({
    int? id,
    double? amount,
    TransactionType? type,
    String? category,
    String? description,
    DateTime? date,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Transaction &&
        other.id == id &&
        other.amount == amount &&
        other.type == type &&
        other.category == category &&
        other.description == description &&
        other.date == date;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      amount.hashCode ^
      type.hashCode ^
      category.hashCode ^
      description.hashCode ^
      date.hashCode;

  @override
  String toString() {
    return 'Transaction('
        'id: $id, '
        'amount: $amount, '
        'type: $type, '
        'category: $category, '
        'description: $description, '
        'date: $date)';
  }

  bool get isIncome => type == TransactionType.income;

  String get title => isIncome ? "Pendapatan" : "Pengeluaraan";
}

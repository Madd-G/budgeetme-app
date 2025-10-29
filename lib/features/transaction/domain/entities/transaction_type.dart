enum TransactionType {
  income,
  expense;

  static TransactionType fromString(String value) {
    return TransactionType.values.firstWhere(
      (type) => type.name.toLowerCase() == value.toLowerCase(),
      orElse: () => TransactionType.expense,
    );
  }

  String get label => name[0].toUpperCase() + name.substring(1);
}

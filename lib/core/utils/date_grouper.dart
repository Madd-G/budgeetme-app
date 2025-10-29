import 'package:budgeetme/core/extensions/date_time_extensions.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';

class DateGrouper {
  DateGrouper._();

  static List<GroupedTransaction> groupByDate(List<Transaction> transactions) {
    if (transactions.isEmpty) return [];

    final nowWib = DateTime.now().toWib();
    final today = nowWib.dateOnly;
    final yesterday = today.subtract(const Duration(days: 1));

    final Map<String, List<Transaction>> grouped = {};

    for (final transaction in transactions) {
      final wib = transaction.date.toWib();
      final date = wib.dateOnly;

      String key;
      if (date == today) {
        key = 'Hari ini';
      } else if (date == yesterday) {
        key = 'Kemarin';
      } else {
        key = date.toGroupingFormat();
      }

      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(transaction);
    }

    return grouped.entries
        .map((entry) => GroupedTransaction(
              dateLabel: entry.key,
              transactions: entry.value,
            ))
        .toList();
  }

}

class GroupedTransaction {
  const GroupedTransaction({
    required this.dateLabel,
    required this.transactions,
  });

  final String dateLabel;
  final List<Transaction> transactions;
}

class TransactionConstants {
  TransactionConstants._();

  static const int incomeCategoryId = 1;
  static const int expenseCategoryId = 2;

  static const List<String> incomeCategories = [
    'Gaji',
    'Bonus',
    'Investasi',
    'Freelance',
    'Hadiah',
    'Lainnya',
  ];

  static const List<String> expenseCategories = [
    'Makanan & Minuman',
    'Transportasi',
    'Belanja',
    'Tagihan',
    'Hiburan',
    'Kesehatan',
    'Pendidikan',
    'Lainnya',
  ];

  static const double minAmount = 0.01;
  static const double maxAmount = 999999999.99;
}

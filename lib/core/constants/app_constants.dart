class AppConstants {
  AppConstants._();

  static const apiBaseUrl = 'https://invenx-backend-app.up.railway.app';
  static const transactionsPaginated = '/transactions/paginated';
  static const transactionsEndpoint = '/transactions';
  static const transactionsSummary = '/transactions/summary';

  static String transactionDetailPath(int id) => '/transactions/$id';
  static String transactionsByCategoryPath(int categoryId) =>
      '/transactions/category/$categoryId/paginated';
  static String transactionsCategorySummaryPath(int categoryId) =>
      '/transactions/category/$categoryId/summary';
}

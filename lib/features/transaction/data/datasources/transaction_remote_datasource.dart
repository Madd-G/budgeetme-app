import 'package:budgeetme/core/constants/app_constants.dart';
import 'package:budgeetme/core/exceptions/app_exception.dart';
import 'package:budgeetme/core/network/api_client.dart';
import 'package:budgeetme/features/transaction/data/models/transaction_model.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_remote_datasource.g.dart';

class TransactionRemoteDataSource {
  TransactionRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<int> createTransaction(TransactionRequestModel request) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        AppConstants.transactionsEndpoint,
        data: request.toJson(),
      );
      final json = response.data;
      if (json == null || json['transactionId'] == null) {
        throw ApiException('Unexpected response creating transaction');
      }
      return (json['transactionId'] as num).toInt();
    } on DioException catch (error) {
      throw NetworkException('Failed to create transaction', cause: error);
    } catch (error) {
      throw ApiException('Unexpected error creating transaction', cause: error);
    }
  }

  Future<void> updateTransaction({
    required int id,
    required TransactionRequestModel request,
  }) async {
    try {
      await _apiClient.put<Map<String, dynamic>>(
        AppConstants.transactionDetailPath(id),
        data: request.toJson(),
      );
    } on DioException catch (error) {
      throw NetworkException('Failed to update transaction', cause: error);
    } catch (error) {
      throw ApiException('Unexpected error updating transaction', cause: error);
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
      await _apiClient.delete<Map<String, dynamic>>(
        AppConstants.transactionDetailPath(id),
      );
    } on DioException catch (error) {
      throw NetworkException('Failed to delete transaction', cause: error);
    } catch (error) {
      throw ApiException('Unexpected error deleting transaction', cause: error);
    }
  }
}

@Riverpod(keepAlive: true)
TransactionRemoteDataSource transactionRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return TransactionRemoteDataSource(apiClient);
}

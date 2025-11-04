import 'dart:developer';

import 'package:budgeetme/core/constants/app_constants.dart';
import 'package:budgeetme/core/exceptions/app_exception.dart';
import 'package:budgeetme/core/network/api_client.dart';
import 'package:budgeetme/features/transaction/data/models/transaction_model.dart';
import 'package:budgeetme/features/dashboard/data/models/dashboard_summary_model.dart';
import 'package:budgeetme/features/dashboard/data/models/transaction_paginated_response.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_remote_datasource.g.dart';

class DashboardRemoteDataSource {
  const DashboardRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<DashboardSummaryModel> fetchSummary() async {
    try {
      final response = await _apiClient.get(AppConstants.transactionsSummary);
      final json = response.data;
      if (json == null) {
        throw ApiException('Empty response loading transaction summary');
      }
      return DashboardSummaryModel.fromJson(json);
    } on DioException catch (error) {
      throw NetworkException(
        'Failed to load transaction summary',
        cause: error,
      );
    } catch (error) {
      throw ApiException(
        'Unexpected error loading transaction summary',
        cause: error,
      );
    }
  }

  Future<TransactionPaginatedResponse> fetchTransactions({int page = 1}) async {
    try {
      final response = await _apiClient.get(
        '${AppConstants.transactionsPaginated}?page=$page',
      );
      final data = response.data;
      if (data == null) {
        log('[TransactionDataSource] Response data is null');
        throw ApiException('Empty response loading transactions');
      }

      return TransactionPaginatedResponse.fromJson(data);
    } on DioException catch (error) {
      throw NetworkException('Failed to load transactions', cause: error);
    } catch (error, stackTrace) {
      log('[TransactionDataSource] Unexpected error: $error');
      log('[TransactionDataSource] Stack trace: $stackTrace');
      throw ApiException('Unexpected error loading transactions', cause: error);
    }
  }

  Future<TransactionPaginatedResponse> fetchTransactionsByCategory({
    required int categoryId,
    int page = 1,
  }) async {
    try {
      final response = await _apiClient.get(
        '${AppConstants.transactionsByCategoryPath(categoryId)}?page=$page',
      );
      final data = response.data;
      if (data == null) {
        throw ApiException('Empty response loading category transactions');
      }
      return TransactionPaginatedResponse.fromJson(data);
    } on DioException catch (error) {
      throw NetworkException(
        'Failed to load transactions by category',
        cause: error,
      );
    } catch (error) {
      throw ApiException(
        'Unexpected error loading category transactions',
        cause: error,
      );
    }
  }

  Future<DashboardSummaryModel> fetchCategorySummary(int categoryId) async {
    try {
      final response = await _apiClient.get(
        AppConstants.transactionsCategorySummaryPath(categoryId),
      );
      final json = response.data;
      if (json == null) {
        throw ApiException('Empty response loading category summary');
      }
      return DashboardSummaryModel.fromJson(json);
    } on DioException catch (error) {
      throw NetworkException('Failed to load category summary', cause: error);
    } catch (error) {
      throw ApiException(
        'Unexpected error loading category summary',
        cause: error,
      );
    }
  }

  Future<TransactionModel> fetchTransactionDetail(int id) async {
    try {
      final response = await _apiClient.get(
        AppConstants.transactionDetailPath(id),
      );
      final json = response.data;
      if (json == null) {
        throw ApiException('Empty response loading transaction detail');
      }
      return TransactionModel.fromJson(json);
    } on DioException catch (error) {
      throw NetworkException('Failed to load transaction detail', cause: error);
    } catch (error) {
      throw ApiException(
        'Unexpected error loading transaction detail',
        cause: error,
      );
    }
  }
}

@Riverpod(keepAlive: true)
DashboardRemoteDataSource dashboardRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DashboardRemoteDataSource(apiClient);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_dashboard_summary_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fetchDashboardSummaryUseCase)
const fetchDashboardSummaryUseCaseProvider =
    FetchDashboardSummaryUseCaseProvider._();

final class FetchDashboardSummaryUseCaseProvider
    extends
        $FunctionalProvider<
          FetchDashboardSummaryUseCase,
          FetchDashboardSummaryUseCase,
          FetchDashboardSummaryUseCase
        >
    with $Provider<FetchDashboardSummaryUseCase> {
  const FetchDashboardSummaryUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchDashboardSummaryUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchDashboardSummaryUseCaseHash();

  @$internal
  @override
  $ProviderElement<FetchDashboardSummaryUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FetchDashboardSummaryUseCase create(Ref ref) {
    return fetchDashboardSummaryUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FetchDashboardSummaryUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FetchDashboardSummaryUseCase>(value),
    );
  }
}

String _$fetchDashboardSummaryUseCaseHash() =>
    r'79e9d22e531c6d640a03339a8f24ffa96ed9f881';

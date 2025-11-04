// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_summary_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(transactionSummary)
const transactionSummaryProvider = TransactionSummaryProvider._();

final class TransactionSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<DashboardTransactionSummary>,
          DashboardTransactionSummary,
          FutureOr<DashboardTransactionSummary>
        >
    with
        $FutureModifier<DashboardTransactionSummary>,
        $FutureProvider<DashboardTransactionSummary> {
  const TransactionSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionSummaryHash();

  @$internal
  @override
  $FutureProviderElement<DashboardTransactionSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DashboardTransactionSummary> create(Ref ref) {
    return transactionSummary(ref);
  }
}

String _$transactionSummaryHash() =>
    r'f24a20947f1917270ea3bcc43e63742b26245adc';

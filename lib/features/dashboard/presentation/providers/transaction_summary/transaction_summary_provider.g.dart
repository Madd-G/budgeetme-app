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
          AsyncValue<TransactionSummary>,
          TransactionSummary,
          FutureOr<TransactionSummary>
        >
    with
        $FutureModifier<TransactionSummary>,
        $FutureProvider<TransactionSummary> {
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
  $FutureProviderElement<TransactionSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TransactionSummary> create(Ref ref) {
    return transactionSummary(ref);
  }
}

String _$transactionSummaryHash() =>
    r'66af1770270c3f11c6acc7287ecdc232bd11bffe';

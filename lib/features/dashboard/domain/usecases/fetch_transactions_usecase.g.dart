// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_transactions_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fetchTransactionsUseCase)
const fetchTransactionsUseCaseProvider = FetchTransactionsUseCaseProvider._();

final class FetchTransactionsUseCaseProvider
    extends
        $FunctionalProvider<
          FetchTransactionsUseCase,
          FetchTransactionsUseCase,
          FetchTransactionsUseCase
        >
    with $Provider<FetchTransactionsUseCase> {
  const FetchTransactionsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchTransactionsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchTransactionsUseCaseHash();

  @$internal
  @override
  $ProviderElement<FetchTransactionsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FetchTransactionsUseCase create(Ref ref) {
    return fetchTransactionsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FetchTransactionsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FetchTransactionsUseCase>(value),
    );
  }
}

String _$fetchTransactionsUseCaseHash() =>
    r'afde3986971530974bb724a5d586ef330cb269f0';

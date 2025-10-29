// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_transaction_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(manageTransactionUseCase)
const manageTransactionUseCaseProvider = ManageTransactionUseCaseProvider._();

final class ManageTransactionUseCaseProvider
    extends
        $FunctionalProvider<
          ManageTransactionUseCase,
          ManageTransactionUseCase,
          ManageTransactionUseCase
        >
    with $Provider<ManageTransactionUseCase> {
  const ManageTransactionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'manageTransactionUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$manageTransactionUseCaseHash();

  @$internal
  @override
  $ProviderElement<ManageTransactionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ManageTransactionUseCase create(Ref ref) {
    return manageTransactionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ManageTransactionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ManageTransactionUseCase>(value),
    );
  }
}

String _$manageTransactionUseCaseHash() =>
    r'2d3ff72863cac1a795514c0eac5bc33806d99fbc';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_manage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TransactionManage)
const transactionManageProvider = TransactionManageProvider._();

final class TransactionManageProvider
    extends $NotifierProvider<TransactionManage, AsyncValue<void>> {
  const TransactionManageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionManageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionManageHash();

  @$internal
  @override
  TransactionManage create() => TransactionManage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$transactionManageHash() => r'323a4b6a1a5bac6ca613b2883398fd29858b2dd6';

abstract class _$TransactionManage extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expanded_days_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExpandedDays)
const expandedDaysProvider = ExpandedDaysProvider._();

final class ExpandedDaysProvider
    extends $NotifierProvider<ExpandedDays, Set<String>> {
  const ExpandedDaysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expandedDaysProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expandedDaysHash();

  @$internal
  @override
  ExpandedDays create() => ExpandedDays();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$expandedDaysHash() => r'b716706c5a16a95376219f1d06484ad22ce30a0c';

abstract class _$ExpandedDays extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

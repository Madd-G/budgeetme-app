// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CategoryFilter)
const categoryFilterProvider = CategoryFilterProvider._();

final class CategoryFilterProvider
    extends $NotifierProvider<CategoryFilter, int?> {
  const CategoryFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryFilterHash();

  @$internal
  @override
  CategoryFilter create() => CategoryFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$categoryFilterHash() => r'ce15974b50aa9aabf9efcc0887857f2abdc88a6f';

abstract class _$CategoryFilter extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

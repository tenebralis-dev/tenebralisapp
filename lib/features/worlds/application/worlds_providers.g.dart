// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worlds_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$worldsRepositoryHash() => r'5d5a3309787d32385b617b0258771551042b6604';

/// See also [worldsRepository].
@ProviderFor(worldsRepository)
final worldsRepositoryProvider = AutoDisposeProvider<WorldsRepository>.internal(
  worldsRepository,
  name: r'worldsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$worldsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WorldsRepositoryRef = AutoDisposeProviderRef<WorldsRepository>;
String _$myWorldsHash() => r'198f27b5027718d21706dc6a4772f8e70d914857';

/// See also [myWorlds].
@ProviderFor(myWorlds)
final myWorldsProvider = AutoDisposeFutureProvider<List<World>>.internal(
  myWorlds,
  name: r'myWorldsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myWorldsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyWorldsRef = AutoDisposeFutureProviderRef<List<World>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

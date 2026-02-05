// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$worldRepositoryHash() => r'fc8b56ac242d12fb7cfa5ebbc1f1d2576a0ae1aa';

/// Provider for WorldRepository
///
/// Copied from [worldRepository].
@ProviderFor(worldRepository)
final worldRepositoryProvider = AutoDisposeProvider<WorldRepository>.internal(
  worldRepository,
  name: r'worldRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$worldRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WorldRepositoryRef = AutoDisposeProviderRef<WorldRepository>;
String _$publicWorldsHash() => r'29f32c2442d179613b0dbb5a82813e7bdc5c354c';

/// Provider for public worlds list
///
/// Copied from [publicWorlds].
@ProviderFor(publicWorlds)
final publicWorldsProvider =
    AutoDisposeFutureProvider<List<WorldModel>>.internal(
      publicWorlds,
      name: r'publicWorldsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$publicWorldsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PublicWorldsRef = AutoDisposeFutureProviderRef<List<WorldModel>>;
String _$userWorldsHash() => r'f4a35b05b656be8a489864897c1623a17db8e688';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for user's worlds
///
/// Copied from [userWorlds].
@ProviderFor(userWorlds)
const userWorldsProvider = UserWorldsFamily();

/// Provider for user's worlds
///
/// Copied from [userWorlds].
class UserWorldsFamily extends Family<AsyncValue<List<WorldModel>>> {
  /// Provider for user's worlds
  ///
  /// Copied from [userWorlds].
  const UserWorldsFamily();

  /// Provider for user's worlds
  ///
  /// Copied from [userWorlds].
  UserWorldsProvider call(String userId) {
    return UserWorldsProvider(userId);
  }

  @override
  UserWorldsProvider getProviderOverride(
    covariant UserWorldsProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userWorldsProvider';
}

/// Provider for user's worlds
///
/// Copied from [userWorlds].
class UserWorldsProvider extends AutoDisposeFutureProvider<List<WorldModel>> {
  /// Provider for user's worlds
  ///
  /// Copied from [userWorlds].
  UserWorldsProvider(String userId)
    : this._internal(
        (ref) => userWorlds(ref as UserWorldsRef, userId),
        from: userWorldsProvider,
        name: r'userWorldsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userWorldsHash,
        dependencies: UserWorldsFamily._dependencies,
        allTransitiveDependencies: UserWorldsFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserWorldsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<List<WorldModel>> Function(UserWorldsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserWorldsProvider._internal(
        (ref) => create(ref as UserWorldsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<WorldModel>> createElement() {
    return _UserWorldsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserWorldsProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserWorldsRef on AutoDisposeFutureProviderRef<List<WorldModel>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserWorldsProviderElement
    extends AutoDisposeFutureProviderElement<List<WorldModel>>
    with UserWorldsRef {
  _UserWorldsProviderElement(super.provider);

  @override
  String get userId => (origin as UserWorldsProvider).userId;
}

String _$worldHash() => r'12ac201a757bac205c6981849b22d9cb0d8594f6';

/// Provider for a specific world
///
/// Copied from [world].
@ProviderFor(world)
const worldProvider = WorldFamily();

/// Provider for a specific world
///
/// Copied from [world].
class WorldFamily extends Family<AsyncValue<WorldModel?>> {
  /// Provider for a specific world
  ///
  /// Copied from [world].
  const WorldFamily();

  /// Provider for a specific world
  ///
  /// Copied from [world].
  WorldProvider call(String worldId) {
    return WorldProvider(worldId);
  }

  @override
  WorldProvider getProviderOverride(covariant WorldProvider provider) {
    return call(provider.worldId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'worldProvider';
}

/// Provider for a specific world
///
/// Copied from [world].
class WorldProvider extends AutoDisposeFutureProvider<WorldModel?> {
  /// Provider for a specific world
  ///
  /// Copied from [world].
  WorldProvider(String worldId)
    : this._internal(
        (ref) => world(ref as WorldRef, worldId),
        from: worldProvider,
        name: r'worldProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$worldHash,
        dependencies: WorldFamily._dependencies,
        allTransitiveDependencies: WorldFamily._allTransitiveDependencies,
        worldId: worldId,
      );

  WorldProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.worldId,
  }) : super.internal();

  final String worldId;

  @override
  Override overrideWith(
    FutureOr<WorldModel?> Function(WorldRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WorldProvider._internal(
        (ref) => create(ref as WorldRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        worldId: worldId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<WorldModel?> createElement() {
    return _WorldProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorldProvider && other.worldId == worldId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, worldId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WorldRef on AutoDisposeFutureProviderRef<WorldModel?> {
  /// The parameter `worldId` of this provider.
  String get worldId;
}

class _WorldProviderElement
    extends AutoDisposeFutureProviderElement<WorldModel?>
    with WorldRef {
  _WorldProviderElement(super.provider);

  @override
  String get worldId => (origin as WorldProvider).worldId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

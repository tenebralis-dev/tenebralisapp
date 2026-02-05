// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chronicle_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chronicleRepositoryHash() =>
    r'05c3794a1b9618885e23b7248c28b9643d0f5ccb';

/// Provider for ChronicleRepository
///
/// Copied from [chronicleRepository].
@ProviderFor(chronicleRepository)
final chronicleRepositoryProvider =
    AutoDisposeProvider<ChronicleRepository>.internal(
      chronicleRepository,
      name: r'chronicleRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$chronicleRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChronicleRepositoryRef = AutoDisposeProviderRef<ChronicleRepository>;
String _$userChroniclesHash() => r'9d03c42fdf458c43994c74023d326ad4194fad28';

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

/// Provider for user's chronicles
///
/// Copied from [userChronicles].
@ProviderFor(userChronicles)
const userChroniclesProvider = UserChroniclesFamily();

/// Provider for user's chronicles
///
/// Copied from [userChronicles].
class UserChroniclesFamily extends Family<AsyncValue<List<ChronicleModel>>> {
  /// Provider for user's chronicles
  ///
  /// Copied from [userChronicles].
  const UserChroniclesFamily();

  /// Provider for user's chronicles
  ///
  /// Copied from [userChronicles].
  UserChroniclesProvider call(String userId, {int? limit}) {
    return UserChroniclesProvider(userId, limit: limit);
  }

  @override
  UserChroniclesProvider getProviderOverride(
    covariant UserChroniclesProvider provider,
  ) {
    return call(provider.userId, limit: provider.limit);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userChroniclesProvider';
}

/// Provider for user's chronicles
///
/// Copied from [userChronicles].
class UserChroniclesProvider
    extends AutoDisposeFutureProvider<List<ChronicleModel>> {
  /// Provider for user's chronicles
  ///
  /// Copied from [userChronicles].
  UserChroniclesProvider(String userId, {int? limit})
    : this._internal(
        (ref) => userChronicles(ref as UserChroniclesRef, userId, limit: limit),
        from: userChroniclesProvider,
        name: r'userChroniclesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userChroniclesHash,
        dependencies: UserChroniclesFamily._dependencies,
        allTransitiveDependencies:
            UserChroniclesFamily._allTransitiveDependencies,
        userId: userId,
        limit: limit,
      );

  UserChroniclesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.limit,
  }) : super.internal();

  final String userId;
  final int? limit;

  @override
  Override overrideWith(
    FutureOr<List<ChronicleModel>> Function(UserChroniclesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserChroniclesProvider._internal(
        (ref) => create(ref as UserChroniclesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ChronicleModel>> createElement() {
    return _UserChroniclesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserChroniclesProvider &&
        other.userId == userId &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserChroniclesRef on AutoDisposeFutureProviderRef<List<ChronicleModel>> {
  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `limit` of this provider.
  int? get limit;
}

class _UserChroniclesProviderElement
    extends AutoDisposeFutureProviderElement<List<ChronicleModel>>
    with UserChroniclesRef {
  _UserChroniclesProviderElement(super.provider);

  @override
  String get userId => (origin as UserChroniclesProvider).userId;
  @override
  int? get limit => (origin as UserChroniclesProvider).limit;
}

String _$worldChroniclesHash() => r'664ffe8cd993ad08aeb69484145f98ad673f6b0b';

/// Provider for world chronicles
///
/// Copied from [worldChronicles].
@ProviderFor(worldChronicles)
const worldChroniclesProvider = WorldChroniclesFamily();

/// Provider for world chronicles
///
/// Copied from [worldChronicles].
class WorldChroniclesFamily extends Family<AsyncValue<List<ChronicleModel>>> {
  /// Provider for world chronicles
  ///
  /// Copied from [worldChronicles].
  const WorldChroniclesFamily();

  /// Provider for world chronicles
  ///
  /// Copied from [worldChronicles].
  WorldChroniclesProvider call(String userId, String worldId, {int? limit}) {
    return WorldChroniclesProvider(userId, worldId, limit: limit);
  }

  @override
  WorldChroniclesProvider getProviderOverride(
    covariant WorldChroniclesProvider provider,
  ) {
    return call(provider.userId, provider.worldId, limit: provider.limit);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'worldChroniclesProvider';
}

/// Provider for world chronicles
///
/// Copied from [worldChronicles].
class WorldChroniclesProvider
    extends AutoDisposeFutureProvider<List<ChronicleModel>> {
  /// Provider for world chronicles
  ///
  /// Copied from [worldChronicles].
  WorldChroniclesProvider(String userId, String worldId, {int? limit})
    : this._internal(
        (ref) => worldChronicles(
          ref as WorldChroniclesRef,
          userId,
          worldId,
          limit: limit,
        ),
        from: worldChroniclesProvider,
        name: r'worldChroniclesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$worldChroniclesHash,
        dependencies: WorldChroniclesFamily._dependencies,
        allTransitiveDependencies:
            WorldChroniclesFamily._allTransitiveDependencies,
        userId: userId,
        worldId: worldId,
        limit: limit,
      );

  WorldChroniclesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.worldId,
    required this.limit,
  }) : super.internal();

  final String userId;
  final String worldId;
  final int? limit;

  @override
  Override overrideWith(
    FutureOr<List<ChronicleModel>> Function(WorldChroniclesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WorldChroniclesProvider._internal(
        (ref) => create(ref as WorldChroniclesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        worldId: worldId,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ChronicleModel>> createElement() {
    return _WorldChroniclesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorldChroniclesProvider &&
        other.userId == userId &&
        other.worldId == worldId &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, worldId.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WorldChroniclesRef on AutoDisposeFutureProviderRef<List<ChronicleModel>> {
  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `worldId` of this provider.
  String get worldId;

  /// The parameter `limit` of this provider.
  int? get limit;
}

class _WorldChroniclesProviderElement
    extends AutoDisposeFutureProviderElement<List<ChronicleModel>>
    with WorldChroniclesRef {
  _WorldChroniclesProviderElement(super.provider);

  @override
  String get userId => (origin as WorldChroniclesProvider).userId;
  @override
  String get worldId => (origin as WorldChroniclesProvider).worldId;
  @override
  int? get limit => (origin as WorldChroniclesProvider).limit;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

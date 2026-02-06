// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userSettingsRepositoryHash() =>
    r'0164d0aff0161188f9bf4bd2813950beb789ba54';

/// See also [userSettingsRepository].
@ProviderFor(userSettingsRepository)
final userSettingsRepositoryProvider =
    AutoDisposeProvider<UserSettingsRepository>.internal(
      userSettingsRepository,
      name: r'userSettingsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userSettingsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserSettingsRepositoryRef =
    AutoDisposeProviderRef<UserSettingsRepository>;
String _$currentUserSettingsHash() =>
    r'38e726a15540b0521da6892da111c7d667a6743e';

/// See also [currentUserSettings].
@ProviderFor(currentUserSettings)
final currentUserSettingsProvider =
    AutoDisposeFutureProvider<UserSettings?>.internal(
      currentUserSettings,
      name: r'currentUserSettingsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentUserSettingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserSettingsRef = AutoDisposeFutureProviderRef<UserSettings?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

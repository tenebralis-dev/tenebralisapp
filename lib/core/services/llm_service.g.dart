// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llm_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$llmServiceHash() => r'aedd040480201b0883716c9ef9871680e8948b5f';

/// Provider for LLM Service
///
/// Copied from [llmService].
@ProviderFor(llmService)
final llmServiceProvider = AutoDisposeProvider<LLMService>.internal(
  llmService,
  name: r'llmServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$llmServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LlmServiceRef = AutoDisposeProviderRef<LLMService>;
String _$lLMConfigNotifierHash() => r'b7859b48cdbfa56c351d9e5b363537bfba19264a';

/// Provider for LLM Configuration
///
/// Copied from [LLMConfigNotifier].
@ProviderFor(LLMConfigNotifier)
final lLMConfigNotifierProvider =
    AutoDisposeNotifierProvider<LLMConfigNotifier, LLMConfig>.internal(
      LLMConfigNotifier.new,
      name: r'lLMConfigNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$lLMConfigNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LLMConfigNotifier = AutoDisposeNotifier<LLMConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

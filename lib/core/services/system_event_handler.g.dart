// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_event_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$systemEventHandlerHash() =>
    r'7ad26dfe861e38de703b2cbf6b3b9c42bfebc24d';

/// Provider for System Event Handler
///
/// Copied from [systemEventHandler].
@ProviderFor(systemEventHandler)
final systemEventHandlerProvider =
    AutoDisposeProvider<SystemEventHandler>.internal(
      systemEventHandler,
      name: r'systemEventHandlerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$systemEventHandlerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SystemEventHandlerRef = AutoDisposeProviderRef<SystemEventHandler>;
String _$eventProcessorHash() => r'b7a5bb25573d0a8339af61300d46ee6ed82d1dfe';

/// Provider for processing events and showing results
///
/// Copied from [EventProcessor].
@ProviderFor(EventProcessor)
final eventProcessorProvider =
    AutoDisposeNotifierProvider<
      EventProcessor,
      List<EventProcessingResult>
    >.internal(
      EventProcessor.new,
      name: r'eventProcessorProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$eventProcessorHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$EventProcessor = AutoDisposeNotifier<List<EventProcessingResult>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

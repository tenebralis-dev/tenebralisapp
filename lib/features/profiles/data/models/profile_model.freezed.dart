// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return _ProfileModel.fromJson(json);
}

/// @nodoc
mixin _$ProfileModel {
  /// UUID primary key
  String get id => throw _privateConstructorUsedError;

  /// Global points accumulated across all worlds
  @JsonKey(name: 'global_points')
  int get globalPoints => throw _privateConstructorUsedError;

  /// User preferences (theme, language, etc.)
  @JsonKey(fromJson: _userPreferencesFromJson)
  UserPreferences? get preferences => throw _privateConstructorUsedError;

  /// User inventory (items, collectibles)
  @JsonKey(fromJson: _userInventoryFromJson)
  UserInventory? get inventory => throw _privateConstructorUsedError;

  /// Current session state
  @JsonKey(name: 'current_session', fromJson: _sessionStateFromJson)
  SessionState? get currentSession => throw _privateConstructorUsedError;

  /// Timestamps
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileModelCopyWith<ProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileModelCopyWith<$Res> {
  factory $ProfileModelCopyWith(
    ProfileModel value,
    $Res Function(ProfileModel) then,
  ) = _$ProfileModelCopyWithImpl<$Res, ProfileModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'global_points') int globalPoints,
    @JsonKey(fromJson: _userPreferencesFromJson) UserPreferences? preferences,
    @JsonKey(fromJson: _userInventoryFromJson) UserInventory? inventory,
    @JsonKey(name: 'current_session', fromJson: _sessionStateFromJson)
    SessionState? currentSession,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });

  $UserPreferencesCopyWith<$Res>? get preferences;
  $UserInventoryCopyWith<$Res>? get inventory;
  $SessionStateCopyWith<$Res>? get currentSession;
}

/// @nodoc
class _$ProfileModelCopyWithImpl<$Res, $Val extends ProfileModel>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? globalPoints = null,
    Object? preferences = freezed,
    Object? inventory = freezed,
    Object? currentSession = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            globalPoints: null == globalPoints
                ? _value.globalPoints
                : globalPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            preferences: freezed == preferences
                ? _value.preferences
                : preferences // ignore: cast_nullable_to_non_nullable
                      as UserPreferences?,
            inventory: freezed == inventory
                ? _value.inventory
                : inventory // ignore: cast_nullable_to_non_nullable
                      as UserInventory?,
            currentSession: freezed == currentSession
                ? _value.currentSession
                : currentSession // ignore: cast_nullable_to_non_nullable
                      as SessionState?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserPreferencesCopyWith<$Res>? get preferences {
    if (_value.preferences == null) {
      return null;
    }

    return $UserPreferencesCopyWith<$Res>(_value.preferences!, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserInventoryCopyWith<$Res>? get inventory {
    if (_value.inventory == null) {
      return null;
    }

    return $UserInventoryCopyWith<$Res>(_value.inventory!, (value) {
      return _then(_value.copyWith(inventory: value) as $Val);
    });
  }

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SessionStateCopyWith<$Res>? get currentSession {
    if (_value.currentSession == null) {
      return null;
    }

    return $SessionStateCopyWith<$Res>(_value.currentSession!, (value) {
      return _then(_value.copyWith(currentSession: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileModelImplCopyWith<$Res>
    implements $ProfileModelCopyWith<$Res> {
  factory _$$ProfileModelImplCopyWith(
    _$ProfileModelImpl value,
    $Res Function(_$ProfileModelImpl) then,
  ) = __$$ProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'global_points') int globalPoints,
    @JsonKey(fromJson: _userPreferencesFromJson) UserPreferences? preferences,
    @JsonKey(fromJson: _userInventoryFromJson) UserInventory? inventory,
    @JsonKey(name: 'current_session', fromJson: _sessionStateFromJson)
    SessionState? currentSession,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });

  @override
  $UserPreferencesCopyWith<$Res>? get preferences;
  @override
  $UserInventoryCopyWith<$Res>? get inventory;
  @override
  $SessionStateCopyWith<$Res>? get currentSession;
}

/// @nodoc
class __$$ProfileModelImplCopyWithImpl<$Res>
    extends _$ProfileModelCopyWithImpl<$Res, _$ProfileModelImpl>
    implements _$$ProfileModelImplCopyWith<$Res> {
  __$$ProfileModelImplCopyWithImpl(
    _$ProfileModelImpl _value,
    $Res Function(_$ProfileModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? globalPoints = null,
    Object? preferences = freezed,
    Object? inventory = freezed,
    Object? currentSession = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ProfileModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        globalPoints: null == globalPoints
            ? _value.globalPoints
            : globalPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        preferences: freezed == preferences
            ? _value.preferences
            : preferences // ignore: cast_nullable_to_non_nullable
                  as UserPreferences?,
        inventory: freezed == inventory
            ? _value.inventory
            : inventory // ignore: cast_nullable_to_non_nullable
                  as UserInventory?,
        currentSession: freezed == currentSession
            ? _value.currentSession
            : currentSession // ignore: cast_nullable_to_non_nullable
                  as SessionState?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileModelImpl implements _ProfileModel {
  const _$ProfileModelImpl({
    required this.id,
    @JsonKey(name: 'global_points') this.globalPoints = 0,
    @JsonKey(fromJson: _userPreferencesFromJson) this.preferences,
    @JsonKey(fromJson: _userInventoryFromJson) this.inventory,
    @JsonKey(name: 'current_session', fromJson: _sessionStateFromJson)
    this.currentSession,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory _$ProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileModelImplFromJson(json);

  /// UUID primary key
  @override
  final String id;

  /// Global points accumulated across all worlds
  @override
  @JsonKey(name: 'global_points')
  final int globalPoints;

  /// User preferences (theme, language, etc.)
  @override
  @JsonKey(fromJson: _userPreferencesFromJson)
  final UserPreferences? preferences;

  /// User inventory (items, collectibles)
  @override
  @JsonKey(fromJson: _userInventoryFromJson)
  final UserInventory? inventory;

  /// Current session state
  @override
  @JsonKey(name: 'current_session', fromJson: _sessionStateFromJson)
  final SessionState? currentSession;

  /// Timestamps
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ProfileModel(id: $id, globalPoints: $globalPoints, preferences: $preferences, inventory: $inventory, currentSession: $currentSession, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.globalPoints, globalPoints) ||
                other.globalPoints == globalPoints) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences) &&
            (identical(other.inventory, inventory) ||
                other.inventory == inventory) &&
            (identical(other.currentSession, currentSession) ||
                other.currentSession == currentSession) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    globalPoints,
    preferences,
    inventory,
    currentSession,
    createdAt,
    updatedAt,
  );

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      __$$ProfileModelImplCopyWithImpl<_$ProfileModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileModelImplToJson(this);
  }
}

abstract class _ProfileModel implements ProfileModel {
  const factory _ProfileModel({
    required final String id,
    @JsonKey(name: 'global_points') final int globalPoints,
    @JsonKey(fromJson: _userPreferencesFromJson)
    final UserPreferences? preferences,
    @JsonKey(fromJson: _userInventoryFromJson) final UserInventory? inventory,
    @JsonKey(name: 'current_session', fromJson: _sessionStateFromJson)
    final SessionState? currentSession,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
  }) = _$ProfileModelImpl;

  factory _ProfileModel.fromJson(Map<String, dynamic> json) =
      _$ProfileModelImpl.fromJson;

  /// UUID primary key
  @override
  String get id;

  /// Global points accumulated across all worlds
  @override
  @JsonKey(name: 'global_points')
  int get globalPoints;

  /// User preferences (theme, language, etc.)
  @override
  @JsonKey(fromJson: _userPreferencesFromJson)
  UserPreferences? get preferences;

  /// User inventory (items, collectibles)
  @override
  @JsonKey(fromJson: _userInventoryFromJson)
  UserInventory? get inventory;

  /// Current session state
  @override
  @JsonKey(name: 'current_session', fromJson: _sessionStateFromJson)
  SessionState? get currentSession;

  /// Timestamps
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) {
  return _UserPreferences.fromJson(json);
}

/// @nodoc
mixin _$UserPreferences {
  /// Theme mode: 'dark' | 'light' | 'system'
  String get theme => throw _privateConstructorUsedError;

  /// Language code: 'zh' | 'en'
  String get language => throw _privateConstructorUsedError;

  /// Notification settings
  bool get notificationsEnabled => throw _privateConstructorUsedError;

  /// Sound effects enabled
  bool get soundEnabled => throw _privateConstructorUsedError;

  /// Haptic feedback enabled
  bool get hapticEnabled => throw _privateConstructorUsedError;

  /// Custom wallpaper path
  String? get wallpaperPath => throw _privateConstructorUsedError;

  /// Serializes this UserPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPreferencesCopyWith<UserPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPreferencesCopyWith<$Res> {
  factory $UserPreferencesCopyWith(
    UserPreferences value,
    $Res Function(UserPreferences) then,
  ) = _$UserPreferencesCopyWithImpl<$Res, UserPreferences>;
  @useResult
  $Res call({
    String theme,
    String language,
    bool notificationsEnabled,
    bool soundEnabled,
    bool hapticEnabled,
    String? wallpaperPath,
  });
}

/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res, $Val extends UserPreferences>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? language = null,
    Object? notificationsEnabled = null,
    Object? soundEnabled = null,
    Object? hapticEnabled = null,
    Object? wallpaperPath = freezed,
  }) {
    return _then(
      _value.copyWith(
            theme: null == theme
                ? _value.theme
                : theme // ignore: cast_nullable_to_non_nullable
                      as String,
            language: null == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String,
            notificationsEnabled: null == notificationsEnabled
                ? _value.notificationsEnabled
                : notificationsEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            soundEnabled: null == soundEnabled
                ? _value.soundEnabled
                : soundEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            hapticEnabled: null == hapticEnabled
                ? _value.hapticEnabled
                : hapticEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            wallpaperPath: freezed == wallpaperPath
                ? _value.wallpaperPath
                : wallpaperPath // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserPreferencesImplCopyWith<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  factory _$$UserPreferencesImplCopyWith(
    _$UserPreferencesImpl value,
    $Res Function(_$UserPreferencesImpl) then,
  ) = __$$UserPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String theme,
    String language,
    bool notificationsEnabled,
    bool soundEnabled,
    bool hapticEnabled,
    String? wallpaperPath,
  });
}

/// @nodoc
class __$$UserPreferencesImplCopyWithImpl<$Res>
    extends _$UserPreferencesCopyWithImpl<$Res, _$UserPreferencesImpl>
    implements _$$UserPreferencesImplCopyWith<$Res> {
  __$$UserPreferencesImplCopyWithImpl(
    _$UserPreferencesImpl _value,
    $Res Function(_$UserPreferencesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? language = null,
    Object? notificationsEnabled = null,
    Object? soundEnabled = null,
    Object? hapticEnabled = null,
    Object? wallpaperPath = freezed,
  }) {
    return _then(
      _$UserPreferencesImpl(
        theme: null == theme
            ? _value.theme
            : theme // ignore: cast_nullable_to_non_nullable
                  as String,
        language: null == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String,
        notificationsEnabled: null == notificationsEnabled
            ? _value.notificationsEnabled
            : notificationsEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        soundEnabled: null == soundEnabled
            ? _value.soundEnabled
            : soundEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        hapticEnabled: null == hapticEnabled
            ? _value.hapticEnabled
            : hapticEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        wallpaperPath: freezed == wallpaperPath
            ? _value.wallpaperPath
            : wallpaperPath // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPreferencesImpl implements _UserPreferences {
  const _$UserPreferencesImpl({
    this.theme = 'dark',
    this.language = 'zh',
    this.notificationsEnabled = true,
    this.soundEnabled = true,
    this.hapticEnabled = true,
    this.wallpaperPath,
  });

  factory _$UserPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPreferencesImplFromJson(json);

  /// Theme mode: 'dark' | 'light' | 'system'
  @override
  @JsonKey()
  final String theme;

  /// Language code: 'zh' | 'en'
  @override
  @JsonKey()
  final String language;

  /// Notification settings
  @override
  @JsonKey()
  final bool notificationsEnabled;

  /// Sound effects enabled
  @override
  @JsonKey()
  final bool soundEnabled;

  /// Haptic feedback enabled
  @override
  @JsonKey()
  final bool hapticEnabled;

  /// Custom wallpaper path
  @override
  final String? wallpaperPath;

  @override
  String toString() {
    return 'UserPreferences(theme: $theme, language: $language, notificationsEnabled: $notificationsEnabled, soundEnabled: $soundEnabled, hapticEnabled: $hapticEnabled, wallpaperPath: $wallpaperPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPreferencesImpl &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(other.soundEnabled, soundEnabled) ||
                other.soundEnabled == soundEnabled) &&
            (identical(other.hapticEnabled, hapticEnabled) ||
                other.hapticEnabled == hapticEnabled) &&
            (identical(other.wallpaperPath, wallpaperPath) ||
                other.wallpaperPath == wallpaperPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    theme,
    language,
    notificationsEnabled,
    soundEnabled,
    hapticEnabled,
    wallpaperPath,
  );

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      __$$UserPreferencesImplCopyWithImpl<_$UserPreferencesImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPreferencesImplToJson(this);
  }
}

abstract class _UserPreferences implements UserPreferences {
  const factory _UserPreferences({
    final String theme,
    final String language,
    final bool notificationsEnabled,
    final bool soundEnabled,
    final bool hapticEnabled,
    final String? wallpaperPath,
  }) = _$UserPreferencesImpl;

  factory _UserPreferences.fromJson(Map<String, dynamic> json) =
      _$UserPreferencesImpl.fromJson;

  /// Theme mode: 'dark' | 'light' | 'system'
  @override
  String get theme;

  /// Language code: 'zh' | 'en'
  @override
  String get language;

  /// Notification settings
  @override
  bool get notificationsEnabled;

  /// Sound effects enabled
  @override
  bool get soundEnabled;

  /// Haptic feedback enabled
  @override
  bool get hapticEnabled;

  /// Custom wallpaper path
  @override
  String? get wallpaperPath;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserInventory _$UserInventoryFromJson(Map<String, dynamic> json) {
  return _UserInventory.fromJson(json);
}

/// @nodoc
mixin _$UserInventory {
  /// List of owned item IDs
  List<String> get items => throw _privateConstructorUsedError;

  /// List of unlocked achievement IDs
  List<String> get achievements => throw _privateConstructorUsedError;

  /// List of unlocked world IDs
  List<String> get unlockedWorlds => throw _privateConstructorUsedError;

  /// Currency balances
  Map<String, int> get currencies => throw _privateConstructorUsedError;

  /// Serializes this UserInventory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserInventory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserInventoryCopyWith<UserInventory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInventoryCopyWith<$Res> {
  factory $UserInventoryCopyWith(
    UserInventory value,
    $Res Function(UserInventory) then,
  ) = _$UserInventoryCopyWithImpl<$Res, UserInventory>;
  @useResult
  $Res call({
    List<String> items,
    List<String> achievements,
    List<String> unlockedWorlds,
    Map<String, int> currencies,
  });
}

/// @nodoc
class _$UserInventoryCopyWithImpl<$Res, $Val extends UserInventory>
    implements $UserInventoryCopyWith<$Res> {
  _$UserInventoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserInventory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? achievements = null,
    Object? unlockedWorlds = null,
    Object? currencies = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            achievements: null == achievements
                ? _value.achievements
                : achievements // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            unlockedWorlds: null == unlockedWorlds
                ? _value.unlockedWorlds
                : unlockedWorlds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            currencies: null == currencies
                ? _value.currencies
                : currencies // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserInventoryImplCopyWith<$Res>
    implements $UserInventoryCopyWith<$Res> {
  factory _$$UserInventoryImplCopyWith(
    _$UserInventoryImpl value,
    $Res Function(_$UserInventoryImpl) then,
  ) = __$$UserInventoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<String> items,
    List<String> achievements,
    List<String> unlockedWorlds,
    Map<String, int> currencies,
  });
}

/// @nodoc
class __$$UserInventoryImplCopyWithImpl<$Res>
    extends _$UserInventoryCopyWithImpl<$Res, _$UserInventoryImpl>
    implements _$$UserInventoryImplCopyWith<$Res> {
  __$$UserInventoryImplCopyWithImpl(
    _$UserInventoryImpl _value,
    $Res Function(_$UserInventoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserInventory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? achievements = null,
    Object? unlockedWorlds = null,
    Object? currencies = null,
  }) {
    return _then(
      _$UserInventoryImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        achievements: null == achievements
            ? _value._achievements
            : achievements // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        unlockedWorlds: null == unlockedWorlds
            ? _value._unlockedWorlds
            : unlockedWorlds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        currencies: null == currencies
            ? _value._currencies
            : currencies // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserInventoryImpl implements _UserInventory {
  const _$UserInventoryImpl({
    final List<String> items = const [],
    final List<String> achievements = const [],
    final List<String> unlockedWorlds = const [],
    final Map<String, int> currencies = const {},
  }) : _items = items,
       _achievements = achievements,
       _unlockedWorlds = unlockedWorlds,
       _currencies = currencies;

  factory _$UserInventoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInventoryImplFromJson(json);

  /// List of owned item IDs
  final List<String> _items;

  /// List of owned item IDs
  @override
  @JsonKey()
  List<String> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// List of unlocked achievement IDs
  final List<String> _achievements;

  /// List of unlocked achievement IDs
  @override
  @JsonKey()
  List<String> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

  /// List of unlocked world IDs
  final List<String> _unlockedWorlds;

  /// List of unlocked world IDs
  @override
  @JsonKey()
  List<String> get unlockedWorlds {
    if (_unlockedWorlds is EqualUnmodifiableListView) return _unlockedWorlds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unlockedWorlds);
  }

  /// Currency balances
  final Map<String, int> _currencies;

  /// Currency balances
  @override
  @JsonKey()
  Map<String, int> get currencies {
    if (_currencies is EqualUnmodifiableMapView) return _currencies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_currencies);
  }

  @override
  String toString() {
    return 'UserInventory(items: $items, achievements: $achievements, unlockedWorlds: $unlockedWorlds, currencies: $currencies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInventoryImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(
              other._achievements,
              _achievements,
            ) &&
            const DeepCollectionEquality().equals(
              other._unlockedWorlds,
              _unlockedWorlds,
            ) &&
            const DeepCollectionEquality().equals(
              other._currencies,
              _currencies,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    const DeepCollectionEquality().hash(_achievements),
    const DeepCollectionEquality().hash(_unlockedWorlds),
    const DeepCollectionEquality().hash(_currencies),
  );

  /// Create a copy of UserInventory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInventoryImplCopyWith<_$UserInventoryImpl> get copyWith =>
      __$$UserInventoryImplCopyWithImpl<_$UserInventoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInventoryImplToJson(this);
  }
}

abstract class _UserInventory implements UserInventory {
  const factory _UserInventory({
    final List<String> items,
    final List<String> achievements,
    final List<String> unlockedWorlds,
    final Map<String, int> currencies,
  }) = _$UserInventoryImpl;

  factory _UserInventory.fromJson(Map<String, dynamic> json) =
      _$UserInventoryImpl.fromJson;

  /// List of owned item IDs
  @override
  List<String> get items;

  /// List of unlocked achievement IDs
  @override
  List<String> get achievements;

  /// List of unlocked world IDs
  @override
  List<String> get unlockedWorlds;

  /// Currency balances
  @override
  Map<String, int> get currencies;

  /// Create a copy of UserInventory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserInventoryImplCopyWith<_$UserInventoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionState _$SessionStateFromJson(Map<String, dynamic> json) {
  return _SessionState.fromJson(json);
}

/// @nodoc
mixin _$SessionState {
  /// Current world ID (if in a world)
  String? get currentWorldId => throw _privateConstructorUsedError;

  /// Current NPC ID (if in conversation)
  String? get currentNpcId => throw _privateConstructorUsedError;

  /// Current quest ID (if active)
  String? get currentQuestId => throw _privateConstructorUsedError;

  /// Last activity timestamp
  DateTime? get lastActivity => throw _privateConstructorUsedError;

  /// Session metadata
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this SessionState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionStateCopyWith<SessionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionStateCopyWith<$Res> {
  factory $SessionStateCopyWith(
    SessionState value,
    $Res Function(SessionState) then,
  ) = _$SessionStateCopyWithImpl<$Res, SessionState>;
  @useResult
  $Res call({
    String? currentWorldId,
    String? currentNpcId,
    String? currentQuestId,
    DateTime? lastActivity,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class _$SessionStateCopyWithImpl<$Res, $Val extends SessionState>
    implements $SessionStateCopyWith<$Res> {
  _$SessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentWorldId = freezed,
    Object? currentNpcId = freezed,
    Object? currentQuestId = freezed,
    Object? lastActivity = freezed,
    Object? metadata = null,
  }) {
    return _then(
      _value.copyWith(
            currentWorldId: freezed == currentWorldId
                ? _value.currentWorldId
                : currentWorldId // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentNpcId: freezed == currentNpcId
                ? _value.currentNpcId
                : currentNpcId // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentQuestId: freezed == currentQuestId
                ? _value.currentQuestId
                : currentQuestId // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastActivity: freezed == lastActivity
                ? _value.lastActivity
                : lastActivity // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SessionStateImplCopyWith<$Res>
    implements $SessionStateCopyWith<$Res> {
  factory _$$SessionStateImplCopyWith(
    _$SessionStateImpl value,
    $Res Function(_$SessionStateImpl) then,
  ) = __$$SessionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? currentWorldId,
    String? currentNpcId,
    String? currentQuestId,
    DateTime? lastActivity,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class __$$SessionStateImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$SessionStateImpl>
    implements _$$SessionStateImplCopyWith<$Res> {
  __$$SessionStateImplCopyWithImpl(
    _$SessionStateImpl _value,
    $Res Function(_$SessionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentWorldId = freezed,
    Object? currentNpcId = freezed,
    Object? currentQuestId = freezed,
    Object? lastActivity = freezed,
    Object? metadata = null,
  }) {
    return _then(
      _$SessionStateImpl(
        currentWorldId: freezed == currentWorldId
            ? _value.currentWorldId
            : currentWorldId // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentNpcId: freezed == currentNpcId
            ? _value.currentNpcId
            : currentNpcId // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentQuestId: freezed == currentQuestId
            ? _value.currentQuestId
            : currentQuestId // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastActivity: freezed == lastActivity
            ? _value.lastActivity
            : lastActivity // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionStateImpl implements _SessionState {
  const _$SessionStateImpl({
    this.currentWorldId,
    this.currentNpcId,
    this.currentQuestId,
    this.lastActivity,
    final Map<String, dynamic> metadata = const {},
  }) : _metadata = metadata;

  factory _$SessionStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionStateImplFromJson(json);

  /// Current world ID (if in a world)
  @override
  final String? currentWorldId;

  /// Current NPC ID (if in conversation)
  @override
  final String? currentNpcId;

  /// Current quest ID (if active)
  @override
  final String? currentQuestId;

  /// Last activity timestamp
  @override
  final DateTime? lastActivity;

  /// Session metadata
  final Map<String, dynamic> _metadata;

  /// Session metadata
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'SessionState(currentWorldId: $currentWorldId, currentNpcId: $currentNpcId, currentQuestId: $currentQuestId, lastActivity: $lastActivity, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionStateImpl &&
            (identical(other.currentWorldId, currentWorldId) ||
                other.currentWorldId == currentWorldId) &&
            (identical(other.currentNpcId, currentNpcId) ||
                other.currentNpcId == currentNpcId) &&
            (identical(other.currentQuestId, currentQuestId) ||
                other.currentQuestId == currentQuestId) &&
            (identical(other.lastActivity, lastActivity) ||
                other.lastActivity == lastActivity) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentWorldId,
    currentNpcId,
    currentQuestId,
    lastActivity,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionStateImplCopyWith<_$SessionStateImpl> get copyWith =>
      __$$SessionStateImplCopyWithImpl<_$SessionStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionStateImplToJson(this);
  }
}

abstract class _SessionState implements SessionState {
  const factory _SessionState({
    final String? currentWorldId,
    final String? currentNpcId,
    final String? currentQuestId,
    final DateTime? lastActivity,
    final Map<String, dynamic> metadata,
  }) = _$SessionStateImpl;

  factory _SessionState.fromJson(Map<String, dynamic> json) =
      _$SessionStateImpl.fromJson;

  /// Current world ID (if in a world)
  @override
  String? get currentWorldId;

  /// Current NPC ID (if in conversation)
  @override
  String? get currentNpcId;

  /// Current quest ID (if active)
  @override
  String? get currentQuestId;

  /// Last activity timestamp
  @override
  DateTime? get lastActivity;

  /// Session metadata
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionStateImplCopyWith<_$SessionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

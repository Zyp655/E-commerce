// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_items_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AddItemState {
  String? get imagePath => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get selectedCategory => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  List<String> get sizes => throw _privateConstructorUsedError;
  List<String> get colors => throw _privateConstructorUsedError;
  bool get isDiscounted => throw _privateConstructorUsedError;
  String? get discountPercentage => throw _privateConstructorUsedError;

  /// Create a copy of AddItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddItemStateCopyWith<AddItemState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddItemStateCopyWith<$Res> {
  factory $AddItemStateCopyWith(
    AddItemState value,
    $Res Function(AddItemState) then,
  ) = _$AddItemStateCopyWithImpl<$Res, AddItemState>;
  @useResult
  $Res call({
    String? imagePath,
    bool isLoading,
    String? selectedCategory,
    List<String> categories,
    List<String> sizes,
    List<String> colors,
    bool isDiscounted,
    String? discountPercentage,
  });
}

/// @nodoc
class _$AddItemStateCopyWithImpl<$Res, $Val extends AddItemState>
    implements $AddItemStateCopyWith<$Res> {
  _$AddItemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddItemState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imagePath = freezed,
    Object? isLoading = null,
    Object? selectedCategory = freezed,
    Object? categories = null,
    Object? sizes = null,
    Object? colors = null,
    Object? isDiscounted = null,
    Object? discountPercentage = freezed,
  }) {
    return _then(
      _value.copyWith(
            imagePath: freezed == imagePath
                ? _value.imagePath
                : imagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedCategory: freezed == selectedCategory
                ? _value.selectedCategory
                : selectedCategory // ignore: cast_nullable_to_non_nullable
                      as String?,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            sizes: null == sizes
                ? _value.sizes
                : sizes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            colors: null == colors
                ? _value.colors
                : colors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isDiscounted: null == isDiscounted
                ? _value.isDiscounted
                : isDiscounted // ignore: cast_nullable_to_non_nullable
                      as bool,
            discountPercentage: freezed == discountPercentage
                ? _value.discountPercentage
                : discountPercentage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddItemStateImplCopyWith<$Res>
    implements $AddItemStateCopyWith<$Res> {
  factory _$$AddItemStateImplCopyWith(
    _$AddItemStateImpl value,
    $Res Function(_$AddItemStateImpl) then,
  ) = __$$AddItemStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? imagePath,
    bool isLoading,
    String? selectedCategory,
    List<String> categories,
    List<String> sizes,
    List<String> colors,
    bool isDiscounted,
    String? discountPercentage,
  });
}

/// @nodoc
class __$$AddItemStateImplCopyWithImpl<$Res>
    extends _$AddItemStateCopyWithImpl<$Res, _$AddItemStateImpl>
    implements _$$AddItemStateImplCopyWith<$Res> {
  __$$AddItemStateImplCopyWithImpl(
    _$AddItemStateImpl _value,
    $Res Function(_$AddItemStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddItemState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imagePath = freezed,
    Object? isLoading = null,
    Object? selectedCategory = freezed,
    Object? categories = null,
    Object? sizes = null,
    Object? colors = null,
    Object? isDiscounted = null,
    Object? discountPercentage = freezed,
  }) {
    return _then(
      _$AddItemStateImpl(
        imagePath: freezed == imagePath
            ? _value.imagePath
            : imagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedCategory: freezed == selectedCategory
            ? _value.selectedCategory
            : selectedCategory // ignore: cast_nullable_to_non_nullable
                  as String?,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        sizes: null == sizes
            ? _value._sizes
            : sizes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        colors: null == colors
            ? _value._colors
            : colors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isDiscounted: null == isDiscounted
            ? _value.isDiscounted
            : isDiscounted // ignore: cast_nullable_to_non_nullable
                  as bool,
        discountPercentage: freezed == discountPercentage
            ? _value.discountPercentage
            : discountPercentage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AddItemStateImpl implements _AddItemState {
  const _$AddItemStateImpl({
    this.imagePath,
    this.isLoading = false,
    this.selectedCategory,
    final List<String> categories = const [],
    final List<String> sizes = const [],
    final List<String> colors = const [],
    this.isDiscounted = false,
    this.discountPercentage,
  }) : _categories = categories,
       _sizes = sizes,
       _colors = colors;

  @override
  final String? imagePath;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? selectedCategory;
  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<String> _sizes;
  @override
  @JsonKey()
  List<String> get sizes {
    if (_sizes is EqualUnmodifiableListView) return _sizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sizes);
  }

  final List<String> _colors;
  @override
  @JsonKey()
  List<String> get colors {
    if (_colors is EqualUnmodifiableListView) return _colors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_colors);
  }

  @override
  @JsonKey()
  final bool isDiscounted;
  @override
  final String? discountPercentage;

  @override
  String toString() {
    return 'AddItemState(imagePath: $imagePath, isLoading: $isLoading, selectedCategory: $selectedCategory, categories: $categories, sizes: $sizes, colors: $colors, isDiscounted: $isDiscounted, discountPercentage: $discountPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddItemStateImpl &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            const DeepCollectionEquality().equals(other._sizes, _sizes) &&
            const DeepCollectionEquality().equals(other._colors, _colors) &&
            (identical(other.isDiscounted, isDiscounted) ||
                other.isDiscounted == isDiscounted) &&
            (identical(other.discountPercentage, discountPercentage) ||
                other.discountPercentage == discountPercentage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    imagePath,
    isLoading,
    selectedCategory,
    const DeepCollectionEquality().hash(_categories),
    const DeepCollectionEquality().hash(_sizes),
    const DeepCollectionEquality().hash(_colors),
    isDiscounted,
    discountPercentage,
  );

  /// Create a copy of AddItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddItemStateImplCopyWith<_$AddItemStateImpl> get copyWith =>
      __$$AddItemStateImplCopyWithImpl<_$AddItemStateImpl>(this, _$identity);
}

abstract class _AddItemState implements AddItemState {
  const factory _AddItemState({
    final String? imagePath,
    final bool isLoading,
    final String? selectedCategory,
    final List<String> categories,
    final List<String> sizes,
    final List<String> colors,
    final bool isDiscounted,
    final String? discountPercentage,
  }) = _$AddItemStateImpl;

  @override
  String? get imagePath;
  @override
  bool get isLoading;
  @override
  String? get selectedCategory;
  @override
  List<String> get categories;
  @override
  List<String> get sizes;
  @override
  List<String> get colors;
  @override
  bool get isDiscounted;
  @override
  String? get discountPercentage;

  /// Create a copy of AddItemState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddItemStateImplCopyWith<_$AddItemStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

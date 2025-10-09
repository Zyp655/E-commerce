import 'package:freezed_annotation/freezed_annotation.dart';
part 'add_items_model.freezed.dart';

@freezed
class AddItemState with _$AddItemState {
  const factory AddItemState({
    String? imagePath,
    @Default(false) bool isLoading,
    String? selectedCategory,
    @Default([]) List<String> categories,
    @Default([]) List<String> sizes,
    @Default([]) List<String> colors,
    @Default(false) bool isDiscounted,
    String? discountPercentage,
    String? errorMessage,
    @Default(false) bool isSuccess,
  }) = _AddItemState;
}

// class AddItemState{
//   final String? imagePath;
//   final bool isLoading;
//   final String? selectedCategory;
//   final List<String> categories;
//   final List<String> sizes;
//   final List<String> colors;
//   final bool isDiscounted;
//   final String? discountPercentage;
//
//   AddItemState({
//     this.imagePath,
//     this.isLoading = false,
//     this.selectedCategory,
//     this.categories = const [],
//     this.sizes = const [],
//     this.colors = const[],
//     this.isDiscounted = false,
//     this.discountPercentage,
//
//   });
//   AddItemState copyWith({
//     String? imagePath,
//     bool? isLoading,
//     String? selectedCategory,
//     List<String>? categories,
//     List<String>? sizes,
//     List<String>? colors,
//     bool? isDiscounted,
//   }){
//     return AddItemState(
//     imagePath: imagePath ?? this.imagePath,
//     isLoading: isLoading ?? this.isLoading,
//     selectedCategory: selectedCategory ?? this.selectedCategory,
//     categories: categories ?? this.categories,
//     sizes: sizes ?? this.sizes,
//     colors: colors ?? this.colors,
//     isDiscounted: isDiscounted ?? this.isDiscounted,
//     discountPercentage: discountPercentage ?? this.discountPercentage,
//     );
//   }
//
//
// }


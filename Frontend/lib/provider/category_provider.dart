
import 'package:bai1/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryProvider extends StateNotifier<List<Category>> {
  CategoryProvider() : super([]);
  //set the list of categories
  void setCategories(List<Category> categories) {
    state = categories;
  }
}
final categoryProvider =
    StateNotifierProvider<CategoryProvider, List<Category>>(
        (ref) => CategoryProvider());
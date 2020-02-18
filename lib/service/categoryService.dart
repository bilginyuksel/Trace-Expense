import 'package:trace_expanses/model/category.dart';

abstract class ICategoryService {

  Future<List<Category>> getAllCategories();
  Future<Category> getCategoryById(int id);
  Future<Category> getCategoryByTitle(String title);
  Future<void> saveCategory(Category cat);

}
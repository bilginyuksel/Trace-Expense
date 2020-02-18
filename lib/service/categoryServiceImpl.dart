import 'package:trace_expanses/model/category.dart';
import 'package:trace_expanses/repository/categoryRepository.dart';
import 'package:trace_expanses/service/categoryExceptions.dart';
import 'package:trace_expanses/service/categoryService.dart';

class CategoryServiceImpl extends ICategoryService{

  /*
  in this service i can control if any data exists or not.
  For the client.
  And throw exceptions. */
  CategoryRepository _categoryRepository;
  CategoryServiceImpl(this._categoryRepository);

  @override
  Future<List<Category>> getAllCategories() async{
    List<Map<String, dynamic>> rawList = await _categoryRepository.findAll();
    List<Category> categories = new List();
    rawList.forEach((element) {
      categories.add(Category.fromMap(element));
    });

    return categories;
  }

  @override
  Future<Category> getCategoryById(int id) async{
    return Category.fromMap(await _categoryRepository.findById(id));
  }

  @override
  Future<Category> getCategoryByTitle(String title) async {
    return Category.fromMap(await _categoryRepository.findByTitle(title));
  }

  @override
  Future<void> saveCategory(Category cat) async {
    // Check if any category exists with the same title
    Map<String, dynamic> categoryMap = await _categoryRepository.findByTitle(cat.title);
    if(categoryMap.isEmpty) {
      await _categoryRepository.save(cat);
    }else{
      throw CategoryUniqueTitle("A category exists with the title you've entered.");
    }
  }

}
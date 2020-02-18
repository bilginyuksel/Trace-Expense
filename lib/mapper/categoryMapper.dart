import 'package:trace_expanses/model/category.dart';

class CategoryMapper {

  String findCategoryById(int id){
    return "SELECT * FROM CATEGORY WHERE id='$id'";
  }

  String findCategoryByTitle(String title){
    return "SELECT * FROM CATEGORY WHERE title=$title";
  }

  String findAll(){
    return "SELECT * FROM CATEGORY";
  }

  String saveCategory(Category category){
    return "INSERT INTO CATEGORY (title) VALUES (${category.title})";
  }

  String countAllCategories(){
    return "SELECT COUNT(*) FROM CATEGORY";
  }
 

}

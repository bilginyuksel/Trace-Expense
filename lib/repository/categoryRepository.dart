import 'package:trace_expanses/model/category.dart';
import 'baseRepository.dart';
import 'package:trace_expanses/mapper/categoryMapper.dart';

class CategoryRepository extends BaseSqlRepository {

  CategoryMapper _categoryMapper;

  CategoryRepository(){
    _categoryMapper = CategoryMapper();
  }

  void getExpenses() async{
    List<Map<String,dynamic>> dList = await database.rawQuery("SELECT * FROM EXPENSE");
    dList.forEach((element) {
      print(element);
    });
  }

  void addSomeExpense() async{
    await database.rawQuery("INSERT INTO EXPENSE (price) VALUES (140.25)");
    await database.rawQuery("INSERT INTO EXPENSE (price) VALUES (10.25)");
    await database.rawQuery("INSERT INTO EXPENSE (price) VALUES (32.25)");
    await database.rawQuery("INSERT INTO EXPENSE (price) VALUES (48.35)");
  }

  dynamic getSum() async{
    List<Map> dList = await database.rawQuery("SELECT SUM(price) FROM EXPENSE");
    return dList.single['SUM(price)'];
  } 


  Future<List<Category>> findAll() async{
    List<Map<String, dynamic>> data=  await database.rawQuery(_categoryMapper.findAll());
    List<Category> categories = new List();
    data.forEach((element) {
      categories.add(Category.fromMap(element));
    });
  
    return categories;
  }

  Future<Category> findById(int id) async {
    List<Map> mapList = await database.rawQuery(_categoryMapper.findCategoryById(id));
    return Category.fromMap(mapList.single);
  }

  Future<Category> findByTitle(String title) async{
    List<Map> mapList = await database.rawQuery(_categoryMapper.findCategoryByTitle(title));
    return Category.fromMap(mapList.single);
  }

  Future<void> save(Category model) async{
    await database.rawInsert(_categoryMapper.saveCategory(model));
  }
  
}
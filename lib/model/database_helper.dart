import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_test/model/category.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _database;
  DatabaseHelper._instance();

  String categoryTable = 'category_table';
  String colId = 'id';
  String colName = 'name';
  String colDate = 'date';
  String colCode = 'code';
  String colSynced = 'synced';

  Future<Database> get db async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  Future<Database> _initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "cloud_pos.db";
    final cloudPosDB =
        await openDatabase(path, version: 1, onCreate: _createDB);
    return cloudPosDB;
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $categoryTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colName TEXT,$colCode TEXT,$colDate TEXT , $colSynced BOOLEAN)');
  }

  Future<List<Map<String, dynamic>>> getCategoryMap() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(categoryTable);
    return result;
  }

  Future<List<Category>> getCategoryList() async {
    final List<Map<String, dynamic>> taskMapList = await getCategoryMap();
    final List<Category> categoryList = [];
    taskMapList.forEach((categoryMap) {
      categoryList.add(Category.fromMap(categoryMap));
    });
    categoryList.sort(
        (categoryA, categoryB) => categoryA.date.compareTo(categoryB.date));
    return categoryList;
  }

  // Future<List<Category>> getCategorySearchList(String userInput) async {
  //   Database db = await this.db;
  //   final List<Map<String,dynamic >> result = await db.rawQuery("SELECT * FROM category_table WHERE title OR  body LIKE '%${userInput}%'");
  //   final List<Category> categorySearchList = [];
  //   result.forEach((categoryMap) {
  //     categorySearchList.add(Category.fromMap(categoryMap));
  //   });
  //   categorySearchList.sort(
  //       (categoryA, categoryB) => categoryA.name.compareTo(categoryB.name));
  //       print(categorySearchList);
  //   return categorySearchList;
  // }

  Future<List<Category>> getAllWords() async {
    final db = await this.db;
    var response = await db.query(categoryTable);
    List<Category> list = response.map((c) => Category.fromMap(c)).toList();
    return list;
}

//getting search results
Future<List<Category>> searchResults(String userSearch) async {
    final db = await this.db;
    var response = await db.query(categoryTable, where: '$colCode = ? OR $colName = ?', whereArgs: [userSearch, userSearch]);
    List<Category> list = response.map((c) => Category.fromMap(c)).toList();
    return list;
}

  Future<int> insertCategory(Category category) async {
    Database db = await this.db;
    final int result = await db.insert(categoryTable, category.toMap());
    return result;
  }

  Future<int> updateCategory(Category category) async {
    Database db = await this.db;
    final int result = await db.update(
      categoryTable,
      category.toMap(),
      where: '$colId = ?',
      whereArgs: [category.id],
    );
    return result;
  }

  Future<int> deleteCategory(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      categoryTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }
}

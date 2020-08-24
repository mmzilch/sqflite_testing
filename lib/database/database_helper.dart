import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_test/model/category.dart';
import 'package:sqflite_test/model/item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _database;
  DatabaseHelper._instance();
//Need to add another column which is primary
  String categoryTable = 'category_table';
  String colId = 'id';
  String colDid = 'dId';
  String colLid = 'lId';
  String colName = 'name';
  String colDate = 'date';
  String colCode = 'code';
  String colSynced = 'synced';

  String itemTable = 'item_table';
  String itemColId = 'id';
  String itemColName = 'name';
  String itemColDate = 'date';
  String itemColCode = 'code';
  String itemColCategory = 'category';
  String itemColPrice = 'price';
  String itemColSynced = 'synced';

  Future<Database> get db async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  Future<Database> _initDatabase() async {
    var directory = await getExternalStorageDirectory();
    String path = directory.path + "cloud_pos.db";

    final cloudPosDB =
        await openDatabase(path, version: 1, onCreate: _createDB);
    return cloudPosDB;
  }

  void _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE $categoryTable(
          $colId INTEGER,
          $colLid TEXT,
          $colDid INTEGER,
          $colName TEXT,
          $colCode TEXT,
          $colDate TEXT ,
          $colSynced BOOLEAN
          )''');
    await db.execute('''CREATE TABLE $itemTable(
      $itemColId INTEGER PRIMARY KEY AUTOINCREMENT,
      $itemColName TEXT,
      $itemColCode TEXT,
      $itemColDate TEXT,
      $itemColCategory TEXT,
      $itemColPrice TEXT,
      $itemColSynced BOOLEAN,
      FOREIGN KEY($itemColCategory) REFERENCES $categoryTable ($colName) ON DELETE NO ACTION ON UPDATE NO ACTION
    )''');
  }

  Future<List<Map<String, dynamic>>> getCategoryMap() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(categoryTable);
    return result;
  }

  Future<List<Map<String, dynamic>>> getItemMap() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(itemTable);
    return result;
  }

  Future<List<Map<String, dynamic>>> getNameMap() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT name FROM $categoryTable');
    return result;
  }

  Future<List<Map<String, dynamic>>> getCategoryIdMap(int dId) async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT id FROM $categoryTable WHERE dID = $dId');
    return result;
  }

  Future<List<Map<String, dynamic>>> getItemIdMap() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT id FROM $itemTable');
    return result;
  }

  Future<List<Category>> getNameList() async {
    final List<Map<String, dynamic>> taskMapList = await getNameMap();
    final List<Category> categoryList = [];
    taskMapList.forEach((categoryMap) {
      categoryList.add(Category.fromMap(categoryMap));
    });
    return categoryList;
  }

  Future<List<Category>> getCategoryIdList(int dId) async {
    final List<Map<String, dynamic>> categoryIdMapList =
        await getCategoryIdMap(dId);
    final List<Category> categoryIdList = [];
    categoryIdMapList.forEach((categoryIdMap) {
      categoryIdList.add(Category.fromMap(categoryIdMap));
    });
    return categoryIdList;
  }

  Future<List<Item>> getItemIdList() async {
    final List<Map<String, dynamic>> itemIdMapList = await getItemIdMap();
    final List<Item> itemIdList = [];
    itemIdMapList.forEach((itemIdMap) {
      itemIdList.add(Item.fromMap(itemIdMap));
    });
    return itemIdList;
  }

  Future<List<Category>> getCategoryList() async {
    final List<Map<String, dynamic>> taskMapList = await getCategoryMap();
    final List<Category> categoryList = [];
    taskMapList.forEach((categoryMap) {
      categoryList.add(Category.fromMap(categoryMap));
    });
    categoryList
        .sort((categoryA, categoryB) => categoryA.date.compareTo(categoryB.date));
    return categoryList;
  }

  Future<List<Item>> getItemList() async {
    final List<Map<String, dynamic>> itemMapList = await getItemMap();
    final List<Item> itemList = [];
    itemMapList.forEach((itemMap) {
      itemList.add(Item.fromMap(itemMap));
    });
    itemList.sort((itemA, itemB) => itemA.date.compareTo(itemB.date));
    return itemList;
  }

  Future<List<Map<String, dynamic>>> getSearchMap(
      String userSearch, String column) async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db
        .rawQuery('SELECT * FROM category_table WHERE $column=?', [userSearch]);
    return result;
  }

  Future<List<Map<String, dynamic>>> getItemSearchMap(
      String userSearchItem, String column) async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db
        .rawQuery('SELECT * FROM item_table WHERE $column=?', [userSearchItem]);
    return result;
  }

  Future<List<Category>> getSearchList(String userSearch, String column) async {
    final List<Map<String, dynamic>> taskMapList =
        await getSearchMap(userSearch, column);
    final List<Category> categoryList = [];
    taskMapList.forEach((categoryMap) {
      categoryList.add(Category.fromMap(categoryMap));
    });
    categoryList
        .sort((categoryA, categoryB) => categoryA.id.compareTo(categoryB.id));
    return categoryList;
  }

  Future<List<Item>> getSearchItemList(
      String userSearchItem, String column) async {
    final List<Map<String, dynamic>> itemMapList =
        await getItemSearchMap(userSearchItem, column);
    final List<Item> itemList = [];
    itemMapList.forEach((itemMap) {
      itemList.add(Item.fromMap(itemMap));
    });
    itemList.sort((itemA, itemB) => itemA.date.compareTo(itemB.date));
    return itemList;
  }

  Future<int> insertCategory(Category category) async {
    Database db = await this.db;
    final int result = await db.insert(categoryTable, category.toMap());
    return result;
  }

  Future<int> insertItem(Item item) async {
    Database db = await this.db;
    final int result = await db.insert(itemTable, item.toMap());
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

  Future<int> updateItem(Item item) async {
    Database db = await this.db;
    final int result = await db.update(
      itemTable,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
    return result;
  }

  Future<int> deleteCategory({int id, String databaseName}) async {
    Database db = await this.db;
    final int result = await db.delete(
      databaseName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }
}

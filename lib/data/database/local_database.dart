import 'package:ecommerceapp/data/model/product_model.dart';
import 'package:sqflite/sqflite.dart';
class LocalDatabase {
  static String tablename = "myCart";
  static LocalDatabase getInstance = LocalDatabase._init();

  Database? _database;
  LocalDatabase._init();

  Future<Database> getDb() async {
    if (_database == null) {
      _database = await _initDb("Cart.db");
      return _database!;
    }
    return _database!;
  }

  Future<Database> _initDb(String fileName) async {
    var dbPath = await getDatabasesPath();
    String path = dbPath + fileName;

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
      String textType = "TEXT";
      String intType = "INTEGER";
      String boolType = "INTEGER";
      await db.execute('''
      Create table $tablename(
            _id $idType,
            id $intType,
            count $intType,
            title $textType,
            price $intType
            category $textType,
            image $textType,
            description $textType
      )
      ''');
    });
    print("Database yaratildi");
    return database;
  }

  static Future<Model> insertToDatabase(Model product) async {
    var database = await getInstance.getDb();
    int id = await database.insert(tablename, product.toJson());
    print("HAMMASI YAXSHI");
    return product.copyWith(id: id);
  }

  static Future<List<Model>> getList() async {
    var database = await getInstance.getDb();
    var listOfTodos = await database.query(tablename, columns: [
            "_id", 
            "id", 
            "count", 
            "title", 
            "price", 
            "category", 
            "image", 
            "description", 
    ]);
    List<Model> list = listOfTodos.map((e) => Model.fromJson(e)).toList();

    return list;
  }

  static Future<Model> updateTaskById(Model product) async {
    var database = await getInstance.getDb();
    int id = await database.update(
      tablename,
      product.toJson(),
      where: 'name = ?',
      whereArgs: [product.title],
    );
    print("HAMMASI YAXSHI");
    return product.copyWith(databaseid: id);
  }

  static Future<int> deleteTaskById(int id) async {
    var database = await getInstance.getDb();
    return await database.delete(
      tablename,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteAll() async {
    var database = await getInstance.getDb();
    return await database.delete(
      tablename,
    );
  }
}
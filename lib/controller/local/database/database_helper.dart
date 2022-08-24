import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/cart_model/cart.dart';

class DatabaseHelper {

   String dbName = 'la_Vie.db';
 int dbVersion = 1;
 String tableName = 'userCart';
// //cols
 String colId = 'id';
 String colNoProductsInCart= 'noProductsInCart';
 String colProductId = 'productId';
 String productType = 'productType';
 String colUserId = 'userId';
  DatabaseHelper._instance();
  static final DatabaseHelper helper = DatabaseHelper._instance();

  Future<String> getDbPath() async {
    String dbPath = await getDatabasesPath();
    // String noteDb = dbPath+"/"+'$DB_NAME';
    String noteDb = join(dbPath, dbName);
    return noteDb;
  }

  void _onCreate(Database db) {
    print('create');
    String sql =
        'create table $tableName ($colId integer primary key autoincrement, $colNoProductsInCart integer, $colProductId text,$productType productType $colUserId text)';
    print(sql);
    db.execute(sql);
  }
  Future<Database> getDbInstance() async {
    int oldV = dbVersion - 1;
    String path = await getDbPath();
    // print(DB_VERSION);
    return openDatabase(path,
        version: dbVersion, onCreate: (db, version) => _onCreate(db));
  }

   Future<int> insertDb(Cart cart) async {
    Database db = await getDbInstance();
    return db.insert(tableName, cart.toJson());
  }
    Future<int> deleteFromDb(int id) async {
    Database db = await getDbInstance();
    return db.delete(tableName,where: '$colId=?',whereArgs: [id]);

  }
}

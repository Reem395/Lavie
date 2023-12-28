import 'package:flutter_hackathon/controller/services/app_shared_pref.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/cart_model/cart.dart';

class DatabaseHelper {
  String dbName = 'la_Vie.db';
  int dbVersion = 1;
  String tableName = 'userCart';
// //cols
  String colId = 'id';
  String colNoProductsInCart = 'noProductsInCart';
  String colProductId = 'productId';
  String productType = 'productType';
  String colUserId = 'userId';
  DatabaseHelper._instance();
  static final DatabaseHelper helper = DatabaseHelper._instance();

  Future<String> getDbPath() async {
    String dbPath = await getDatabasesPath();
    String cartDb = join(dbPath, dbName);
    return cartDb;
  }

  void _onCreate(Database db) {
    print('create');
    String sql =
        'create table $tableName ($colId integer primary key autoincrement, $colNoProductsInCart integer, $colProductId text, $productType text, $colUserId text)';
    print(sql);
    db.execute(sql);
  }

  Future<Database> getDbInstance() async {
    String path = await getDbPath();
    // print(DB_VERSION);
    return openDatabase(path,
        version: dbVersion, onCreate: (db, version) => _onCreate(db));
  }

  Future<List<Cart>> getuserCart() async {
    Database db = await getDbInstance();
    List<Map<dynamic, dynamic>> query = await db.query(tableName,
        where: '$colUserId =?',
        whereArgs: [AppSharedPref.getUserId()],
        orderBy: '$colId desc');
    return query.map((e) => Cart.fromJson(e)).toList();
  }

  Future<int> insertDb(Cart cart) async {
    Database db = await getDbInstance();
    print("cart To Json: ${cart.toJson()}");
    return db.insert(tableName, cart.toJson());
  }

  Future<int> updateDb(Cart cart) async {
    Database db = await getDbInstance();
    return db.update(tableName, cart.toJson(),
        where: '$colId=?', whereArgs: [cart.id]);
  }

  Future<int> deleteFromDb(int id) async {
    Database db = await getDbInstance();
    return db.delete(tableName, where: '$colId=?', whereArgs: [id]);
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shopping_list/models/product.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static DatabaseHelper get instance => _instance;

  // Singleton pattern
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Get the path to the database file
    String path = join(await getDatabasesPath(), 'my_app_database.db');

    // Open/create the database
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    // Create the tables
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price INT NOT NULL,
        category STRING NOT NULL,
        status TEXT NOT NULL
      )
    ''');
  }
  // Add these methods to your DatabaseHelper class

  // CREATE - Insert a new product
  Future<int> insertProduct(Product product) async {
    Database db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  // READ - Get all products
  Future<List<Product>> getAllProducts() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  // READ - Get product by ID
  Future<Product?> getProduct(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first);
    }
    return null;
  }

  // UPDATE - Update a product
  Future<int> updateProduct(Product product) async {
    Database db = await instance.database;
    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  // DELETE - Delete a product
  Future<int> deleteProduct(int id) async {
    Database db = await instance.database;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  // DELETE - Delete all products
  Future<int> deleteAllProducts() async {
    Database db = await instance.database;
    return await db.delete('products');
  }
}

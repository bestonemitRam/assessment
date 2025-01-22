import 'package:assessment/data/LostItem.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('lost_items.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE lost_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        contactInfo TEXT,
        itemDescription TEXT,
        date TEXT,
        location TEXT,
        images TEXT
      )
    ''');
  }

  Future<int> insertItem(LostItem item) async {
    final db = await instance.database;
    return await db.insert('lost_items', item.toMap());
  }

  Future<List<LostItem>> fetchItems() async {
    final db = await instance.database;
    final result = await db.query('lost_items');

    return result.map((map) => LostItem.fromMap(map)).toList();
  }

  Future<int> updateItem(LostItem item) async {
    final db = await instance.database;

    return await db.update(
      'lost_items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteItem(int id) async {
    final db = await instance.database;
    return await db.delete('lost_items', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> initDatabase() async {
    await database; // Triggers initialization
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LoginDb {
  static final LoginDb instance = LoginDb._init();
  static Database? _database;

  LoginDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('user_data.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const String textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE users (
      id $idType,
      email $textType,
      password $textType
    )
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert('users', user);
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final db = await instance.database;
    return await db.query('users');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}

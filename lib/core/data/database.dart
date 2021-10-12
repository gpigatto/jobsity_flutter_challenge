import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

final databaseName = 'database.db';
final databaseVersion = 1;

class Database {
  Future<sqflite.Database> getDatabase() async {
    var databasesPath = await sqflite.getDatabasesPath();
    String path = join(databasesPath, databaseName);

    final _createUserTable = '''
      CREATE TABLE USERS (
        id INTEGER PRIMARY KEY, 
        username TEXT, 
        pin TEXT
      )
    ''';

    final _createFavoriteTable = '''
      CREATE TABLE FAVORITES (
        id INTEGER PRIMARY KEY, 
        fk_users INTEGER,
        show_id INTEGER, 
        name TEXT, 
        image_medium TEXT,
        image_original TEXT, 
        rating REAL, 
        premiered TEXT, 
        ended TEXT, 
        summary TEXT, 
        genres_json TEXT
      )
    ''';

    sqflite.Database database = await sqflite.openDatabase(
      path,
      version: databaseVersion,
      onCreate: (sqflite.Database db, int version) async {
        await db.execute(_createUserTable);
        await db.execute(_createFavoriteTable);
      },
    );

    return database;
  }

  Future<void> closeDatabase() async {
    var databasesPath = await sqflite.getDatabasesPath();
    String path = join(databasesPath, databaseName);

    sqflite.Database database = await sqflite.openDatabase(
      path,
      version: databaseVersion,
    );

    await database.close();
  }
}

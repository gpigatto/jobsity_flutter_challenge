import 'package:jobsity_flutter_challenge/core/data/database.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/user_exist_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class UserExistData extends UserExistInterface {
  @override
  Future<bool> call(String username) async {
    sqflite.Database database = await Database().getDatabase();

    final _selectUser = '''
      SELECT 
        ID 
      FROM 
        USERS 
      WHERE 
        username = ?
      LIMIT 1
    ''';

    List<Map> list = await database.rawQuery('SELECT * FROM USERS');

    var id = -1;

    try {
      id = sqflite.Sqflite.firstIntValue(
        await database.rawQuery(
          _selectUser,
          [username],
        ),
      )!;

      print(id);
    } catch (_) {
      print(_);
    }

    await Database().closeDatabase();

    return id > 0;
  }
}

import 'package:jobsity_flutter_challenge/core/data/database.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/register_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/login_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class LoginData extends LoginInterface {
  @override
  Future<int> call(LoginClass login) async {
    sqflite.Database database = await Database().getDatabase();

    final _selectUser = '''
      SELECT 
        ID 
      FROM 
        USERS 
      WHERE 
        username = ? 
        AND pin = ?
      LIMIT 1
    ''';

    var id = -1;

    try {
      id = sqflite.Sqflite.firstIntValue(
        await database.rawQuery(
          _selectUser,
          [login.username, login.pin],
        ),
      )!;
    } catch (_) {}

    await Database().closeDatabase();

    return id;
  }

  Future<void> loginSharedPreferences(int id, String user) async {
    final prefs = await SharedPreferences.getInstance();
    final idKey = 'login_id';
    final userKey = 'login_user';

    prefs.setInt(idKey, id);
    prefs.setString(userKey, user);
  }
}

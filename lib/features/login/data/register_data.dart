import 'package:jobsity_flutter_challenge/core/data/database.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/register_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/register_interface.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class RegisterData extends RegisterInterface {
  @override
  Future<int> call(LoginClass login) async {
    sqflite.Database database = await Database().getDatabase();

    final _insertUser = "INSERT INTO USERS (username, pin) VALUES (?, ?)";

    var result = -1;

    await database.transaction((transaction) async {
      result = await transaction.rawInsert(
        _insertUser,
        [login.username, login.pin],
      );
    });

    await Database().closeDatabase();

    return result;
  }
}

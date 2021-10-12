import 'package:jobsity_flutter_challenge/features/login/domain/commands/get_logged_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/get_logged_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetLoggedData extends GetLoggedInterface {
  @override
  Future<LoggedClass> call() async {
    final prefs = await SharedPreferences.getInstance();
    final idKey = 'login_id';
    final userKey = 'login_user';

    var id = -1;
    var username = '';

    try {
      id = prefs.getInt(idKey)!;
      username = prefs.getString(userKey)!;
    } catch (_) {}

    return LoggedClass(id: id, username: username);
  }
}

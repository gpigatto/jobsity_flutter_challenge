import 'package:jobsity_flutter_challenge/features/login/domain/commands/get_logged_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/logout_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutData extends LogoutInterface {
  @override
  Future<bool> call() async {
    final prefs = await SharedPreferences.getInstance();
    final idKey = 'login_id';
    final userKey = 'login_user';

    try {
      prefs.remove(idKey);
      prefs.remove(userKey);

      return true;
    } catch (_) {
      return false;
    }
  }
}

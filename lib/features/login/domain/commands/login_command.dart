import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/login/data/login_data.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/register_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/login_interface.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/toast.dart';

class LoginCommand extends Command<int, LoginClass> {
  final LoginInterface repo;

  LoginCommand(this.repo);

  @override
  Future<int> call(LoginClass login) async {
    try {
      var result = await repo(login);

      LoginData().loginSharedPreferences(result, login.username);

      return result;
    } catch (e) {
      throw (e);
    }
  }
}

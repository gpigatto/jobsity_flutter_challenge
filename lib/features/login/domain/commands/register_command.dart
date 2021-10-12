import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/register_interface.dart';

class RegisterCommand extends Command<int, LoginClass> {
  final RegisterInterface repo;

  RegisterCommand(this.repo);

  @override
  Future<int> call(LoginClass login) async {
    try {
      var result = await repo(login);

      return result;
    } catch (e) {
      throw (e);
    }
  }
}

class LoginClass {
  LoginClass({
    required this.username,
    required this.pin,
  });

  String username;
  String pin;
}

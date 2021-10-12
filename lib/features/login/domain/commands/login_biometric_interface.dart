import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/register_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/login_biometric_interface.dart';

class LoginBiometricCommand extends Command<LoginClass, String> {
  final LoginBiometricInterface repo;

  LoginBiometricCommand(this.repo);

  @override
  Future<LoginClass> call(String username) async {
    try {
      var result = await repo(username);

      return result;
    } catch (e) {
      throw (e);
    }
  }
}

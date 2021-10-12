import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/register_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/save_biometric_interface.dart';
import 'package:local_auth/local_auth.dart';

class SaveBiometricCommand extends Command<bool, LoginClass> {
  final SaveBiometricInterface repo;

  SaveBiometricCommand(this.repo);

  @override
  Future<bool> call(LoginClass login) async {
    try {
      var result = await repo(login);

      return result;
    } catch (e) {
      throw (e);
    }
  }
}

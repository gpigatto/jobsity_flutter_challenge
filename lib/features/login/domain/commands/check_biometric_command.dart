import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/check_biometric_interface.dart';
import 'package:local_auth/local_auth.dart';

class CheckBiometricCommand extends Command<CheckBiometricClass, String> {
  final CheckBiometricInterface repo;

  CheckBiometricCommand(this.repo);

  @override
  Future<CheckBiometricClass> call(String username) async {
    try {
      final LocalAuthentication auth = LocalAuthentication();

      var device = false;

      if (await auth.canCheckBiometrics && await auth.isDeviceSupported()) {
        device = true;
      }

      var user = await repo(username);

      return CheckBiometricClass(device: device, user: user.user);
    } catch (e) {
      throw (e);
    }
  }
}

class CheckBiometricClass {
  CheckBiometricClass({
    required this.device,
    required this.user,
  });

  bool device;
  bool user;
}

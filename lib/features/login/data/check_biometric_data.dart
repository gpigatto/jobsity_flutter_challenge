import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/check_biometric_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/check_biometric_interface.dart';

class CheckBiometricData extends CheckBiometricInterface {
  @override
  Future<CheckBiometricClass> call(String username) async {
    try {
      var result = await FlutterKeychain.get(key: "${username}_pass");

      return CheckBiometricClass(device: true, user: result != null);
    } catch (_) {
      return CheckBiometricClass(device: true, user: false);
    }
  }
}

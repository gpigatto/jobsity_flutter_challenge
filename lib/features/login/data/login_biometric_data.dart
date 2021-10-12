import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/register_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/login_biometric_interface.dart';

class LoginBiometricData extends LoginBiometricInterface {
  @override
  Future<LoginClass> call(String username) async {
    var password = "";

    password = (await FlutterKeychain.get(key: "${username}_pass"))!;

    return LoginClass(username: username, pin: password);
  }
}

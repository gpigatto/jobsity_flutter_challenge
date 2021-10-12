import 'package:jobsity_flutter_challenge/features/login/domain/commands/register_command.dart';
import 'package:sqflite/sqflite.dart';

abstract class RegisterInterface {
  Future<int> call(LoginClass login);
}

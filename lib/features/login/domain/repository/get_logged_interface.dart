import 'package:jobsity_flutter_challenge/features/login/domain/commands/get_logged_command.dart';

abstract class GetLoggedInterface {
  Future<LoggedClass> call();
}

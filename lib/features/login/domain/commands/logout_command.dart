import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/logout_interface.dart';

class LogoutCommand extends Command<bool, Null> {
  final LogoutInterface repo;

  LogoutCommand(this.repo);

  @override
  Future<bool> call(Null) async {
    try {
      var result = await repo();

      return result;
    } catch (e) {
      throw (e);
    }
  }
}

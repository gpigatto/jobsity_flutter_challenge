import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/user_exist_interface.dart';

class UserExistCommand extends Command<bool, String> {
  final UserExistInterface repo;

  UserExistCommand(this.repo);

  @override
  Future<bool> call(String username) async {
    try {
      var result = await repo(username);

      return result;
    } catch (e) {
      throw (e);
    }
  }
}

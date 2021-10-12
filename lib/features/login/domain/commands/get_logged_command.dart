import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/get_logged_interface.dart';

class GetLoggedCommand extends Command<LoggedClass, Null> {
  final GetLoggedInterface repo;

  GetLoggedCommand(this.repo);

  @override
  Future<LoggedClass> call(Null) async {
    try {
      var result = await repo();

      return result;
    } catch (e) {
      throw (e);
    }
  }
}

class LoggedClass {
  LoggedClass({
    required this.id,
    required this.username,
  });

  int id;
  String username;
}

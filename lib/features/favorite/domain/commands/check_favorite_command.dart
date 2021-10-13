import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/commands/add_favorite_command.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/repository/check_favorite_interface.dart';

class CheckFavoriteCommand extends Command<int, FavoriteClass> {
  final CheckFavoriteInterface repo;

  CheckFavoriteCommand(this.repo);

  @override
  Future<int> call(FavoriteClass page) async {
    try {
      var result = await repo(page);

      return result;
    } catch (e) {
      throw (e);
    }
  }
}

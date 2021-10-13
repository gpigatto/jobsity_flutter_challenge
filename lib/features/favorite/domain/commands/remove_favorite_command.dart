import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/commands/add_favorite_command.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/repository/remove_favorite_interface.dart';

class RemoveFavoriteCommand extends Command<int, FavoriteClass> {
  final RemoveFavoriteInterface repo;

  RemoveFavoriteCommand(this.repo);

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

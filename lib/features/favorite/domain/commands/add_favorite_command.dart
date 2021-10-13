import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/repository/add_favorite_interface.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/feed_body.dart';

class AddFavoriteCommand extends Command<int, FavoriteClass> {
  final AddFavoriteInterface repo;

  AddFavoriteCommand(this.repo);

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

class FavoriteClass {
  final ShowItem showItem;
  final int userId;

  FavoriteClass(this.showItem, this.userId);
}

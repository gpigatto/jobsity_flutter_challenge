import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/repository/favorite_list_interface.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/feed_body.dart';

class FavoriteListCommand extends Command<List<ShowItem>, int> {
  final FavoriteListInterface repo;

  FavoriteListCommand(this.repo);

  @override
  Future<List<ShowItem>> call(int userId) async {
    try {
      var result = await repo(userId);

      return result;
    } catch (e) {
      throw (e);
    }
  }
}

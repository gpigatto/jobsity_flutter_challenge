import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/feed/domain/repository/feed_interface.dart';
import 'package:jobsity_flutter_challenge/features/feed/model/feed_model.dart';

class FeedCommand extends Command<FeedModel, int> {
  final FeedInterface repo;

  FeedCommand(this.repo);

  @override
  Future<FeedModel> call(int page) async {
    try {
      var result = await repo(page);

      return result;
    } catch (e) {
      throw (e);
    }
  }
}

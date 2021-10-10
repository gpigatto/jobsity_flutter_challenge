import 'package:collection/collection.dart';
import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/information/domain/repository/episodes_interface.dart';
import 'package:jobsity_flutter_challenge/features/information/model/episode_list_model.dart';

class EpisodeListCommand extends Command<EpisodeListModel, int> {
  final EpisodeListInterface repo;

  EpisodeListCommand(this.repo);

  @override
  Future<EpisodeListModel> call(int page) async {
    try {
      var result = await repo(page);

      return result;
    } catch (e) {
      throw (e);
    }
  }

  Map<int?, List<EpisodeListModelObjectList>> groupBySeason(
    EpisodeListModel model,
  ) {
    try {
      List<EpisodeListModelObjectList> list = [];

      model.ObjectList!.forEach((k) => list.add(k!));

      var result = groupBy(
        list,
        (EpisodeListModelObjectList obj) => obj.season,
      );

      return result;
    } catch (e) {
      throw (e);
    }
  }
}

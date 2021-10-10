import 'package:jobsity_flutter_challenge/core/commands/command.dart';
import 'package:jobsity_flutter_challenge/features/search/domain/repository/search_show_interface.dart';
import 'package:jobsity_flutter_challenge/features/search/model/search_show_model.dart';

class SearchShowCommand extends Command<SearchShowModel, String> {
  final SearchShowInterface repo;

  SearchShowCommand(this.repo);

  @override
  Future<SearchShowModel> call(String query) async {
    try {
      var result = await repo(
          query.replaceAll(new RegExp(r'[^\w\s]+'), '').replaceAll(" ", "_"));

      return result;
    } catch (e) {
      throw (e);
    }
  }
}

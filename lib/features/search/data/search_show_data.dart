import 'package:jobsity_flutter_challenge/core/infrastructure/endpoints.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/http_client.dart';
import 'package:jobsity_flutter_challenge/features/search/domain/repository/search_show_interface.dart';
import 'package:jobsity_flutter_challenge/features/search/model/search_show_model.dart';

class SearchShowData extends SearchShowInterface {
  @override
  Future<SearchShowModel> call(String query) async {
    var map = await HttpClient.getListAsync(
      '${EndPoints.searchShow}$query',
      headers: {},
    );

    return SearchShowModel.fromJson(map);
  }
}

import 'package:jobsity_flutter_challenge/core/infrastructure/endpoints.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/http_client.dart';
import 'package:jobsity_flutter_challenge/features/information/domain/repository/episodes_interface.dart';
import 'package:jobsity_flutter_challenge/features/information/model/episode_list_model.dart';

class EpisodeListData extends EpisodeListInterface {
  @override
  Future<EpisodeListModel> call(int page) async {
    var map = await HttpClient.getListAsync(
      '${EndPoints.showInformation}$page/episodes',
      headers: {},
    );

    return EpisodeListModel.fromJson(map);
  }
}

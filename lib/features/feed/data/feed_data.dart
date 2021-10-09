import 'package:jobsity_flutter_challenge/core/infrastructure/endpoints.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/http_client.dart';
import 'package:jobsity_flutter_challenge/features/feed/domain/repository/feed_interface.dart';
import 'package:jobsity_flutter_challenge/features/feed/model/feed_model.dart';

class FeedData extends FeedInterface {
  @override
  Future<FeedModel> call(int page) async {
    var map = await HttpClient.getListAsync(
      '${EndPoints.paginatedShowList}$page',
      headers: {},
    );

    return FeedModel.fromJson(map);
  }
}

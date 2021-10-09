import 'package:jobsity_flutter_challenge/features/feed/model/feed_model.dart';

abstract class FeedInterface {
  Future<FeedModel> call(int page);
}

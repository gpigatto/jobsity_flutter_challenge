import 'package:jobsity_flutter_challenge/features/information/model/episode_list_model.dart';

abstract class EpisodeListInterface {
  Future<EpisodeListModel> call(int page);
}

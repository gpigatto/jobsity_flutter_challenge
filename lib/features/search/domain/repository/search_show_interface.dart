import 'package:jobsity_flutter_challenge/features/search/model/search_show_model.dart';

abstract class SearchShowInterface {
  Future<SearchShowModel> call(String query);
}

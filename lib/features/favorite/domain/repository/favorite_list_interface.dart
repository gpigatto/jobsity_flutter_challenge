import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/feed_body.dart';

abstract class FavoriteListInterface {
  Future<List<ShowItem>> call(int userId);
}

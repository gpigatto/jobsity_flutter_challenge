import 'package:jobsity_flutter_challenge/features/favorite/domain/commands/add_favorite_command.dart';

abstract class RemoveFavoriteInterface {
  Future<int> call(FavoriteClass addFavoriteClass);
}

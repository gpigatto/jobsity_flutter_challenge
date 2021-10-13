import 'package:jobsity_flutter_challenge/core/data/database.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/commands/add_favorite_command.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/repository/remove_favorite_interface.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class RemoveFavoriteData extends RemoveFavoriteInterface {
  @override
  Future<int> call(FavoriteClass favoriteClass) async {
    sqflite.Database database = await Database().getDatabase();

    final _deleteFavorite = '''
      DELETE FROM 
        FAVORITES 
      WHERE 
        fk_users = ? 
        AND show_id = ?
    ''';

    var result = -1;

    try {
      result = await database.rawDelete(
        _deleteFavorite,
        [
          favoriteClass.userId,
          favoriteClass.showItem.id,
        ],
      );
    } catch (_) {}

    await Database().closeDatabase();

    return result;
  }
}

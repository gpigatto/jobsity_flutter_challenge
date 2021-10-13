import 'package:jobsity_flutter_challenge/core/data/database.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/commands/add_favorite_command.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/repository/check_favorite_interface.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class CheckFavoriteData extends CheckFavoriteInterface {
  @override
  Future<int> call(FavoriteClass favoriteClass) async {
    sqflite.Database database = await Database().getDatabase();

    final _checkFavorite = '''
      SELECT 
        COUNT(*) 
      FROM 
        FAVORITES 
      WHERE 
        fk_users = ? 
        AND show_id = ?
      LIMIT 1
    ''';

    var result = -1;

    try {
      result = sqflite.Sqflite.firstIntValue(
        await database.rawQuery(
          _checkFavorite,
          [
            favoriteClass.userId,
            favoriteClass.showItem.id,
          ],
        ),
      )!;
    } catch (_) {}

    await Database().closeDatabase();

    return result;
  }
}

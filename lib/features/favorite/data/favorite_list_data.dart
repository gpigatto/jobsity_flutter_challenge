import 'package:jobsity_flutter_challenge/core/data/database.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/commands/add_favorite_command.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/repository/favorite_list_interface.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/feed_body.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class FavoriteListData extends FavoriteListInterface {
  @override
  Future<List<ShowItem>> call(int userId) async {
    sqflite.Database database = await Database().getDatabase();

    final _favoriteList = '''
      SELECT 
        * 
      FROM 
        FAVORITES 
      WHERE 
        fk_users = ? 
      ORDER BY NAME
    ''';

    List<Map> selectList = [];
    List<ShowItem> result = [];

    try {
      selectList = await database.rawQuery(
        _favoriteList,
        [userId],
      );

      result = selectList
          .map(
            (entry) => ShowItem(
              id: entry['show_id'],
              name: entry['name'],
              imageMedium: entry['image_medium'],
              imageOriginal: entry['image_original'],
              premiered: entry['premiered'],
              ended: entry['ended'],
              genres: entry['genres_list'].split(','),
              summary: entry['summary'],
              rating: entry['rating'],
            ),
          )
          .toList();
    } catch (_) {}

    await Database().closeDatabase();

    return result;
  }
}

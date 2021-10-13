import 'dart:convert';

import 'package:jobsity_flutter_challenge/core/data/database.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/commands/add_favorite_command.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/repository/add_favorite_interface.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class AddFavoriteData extends AddFavoriteInterface {
  @override
  Future<int> call(FavoriteClass addFavoriteClass) async {
    sqflite.Database database = await Database().getDatabase();

    final _insertFavorite = '''
      INSERT INTO FAVORITES (
        fk_users, show_id, name, 
        image_medium, image_original, 
        rating, premiered, ended, 
        summary, genres_list
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''';

    var genresList = addFavoriteClass.showItem.genres!.join(',');

    var result = -1;

    await database.transaction((transaction) async {
      result = await transaction.rawInsert(
        _insertFavorite,
        [
          addFavoriteClass.userId,
          addFavoriteClass.showItem.id,
          addFavoriteClass.showItem.name,
          addFavoriteClass.showItem.imageMedium,
          addFavoriteClass.showItem.imageOriginal,
          addFavoriteClass.showItem.rating,
          addFavoriteClass.showItem.premiered,
          addFavoriteClass.showItem.ended,
          addFavoriteClass.showItem.summary,
          genresList,
        ],
      );
    });

    await Database().closeDatabase();

    return result;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:jobsity_flutter_challenge/features/favorite/presentation/widgets/favorite_list_body.dart';
import 'package:jobsity_flutter_challenge/features/favorite/presentation/widgets/favorite_list_header.dart';
import 'package:jobsity_flutter_challenge/shared/pages/simple_body.dart';

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleBody(
      header: FavoriteListHeader(),
      body: FavoriteListBody(),
      scrollable: false,
      headerHaveHeight: false,
    );
  }
}

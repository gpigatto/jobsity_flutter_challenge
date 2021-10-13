import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/commands/add_favorite_command.dart';
import 'package:jobsity_flutter_challenge/features/favorite/presentation/bloc/add_favorite_bloc.dart';
import 'package:jobsity_flutter_challenge/features/favorite/presentation/bloc/check_favorite_bloc.dart';
import 'package:jobsity_flutter_challenge/features/favorite/presentation/bloc/favorite_list_bloc.dart';
import 'package:jobsity_flutter_challenge/features/favorite/presentation/bloc/remove_favorite_bloc.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/feed_body.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/get_logged_bloc.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/button.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/toast.dart';

class InformationHeader extends StatelessWidget {
  final ShowItem showItem;

  const InformationHeader({Key? key, required this.showItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddFavoriteBloc>(
          create: (BuildContext context) => AddFavoriteBloc(serviceLocator()),
        ),
        BlocProvider<RemoveFavoriteBloc>(
          create: (BuildContext context) =>
              RemoveFavoriteBloc(serviceLocator()),
        ),
        BlocProvider<CheckFavoriteBloc>(
          create: (BuildContext context) => CheckFavoriteBloc(serviceLocator()),
        ),
      ],
      child: _InformationHeader(showItem: showItem),
    );
  }
}

class _InformationHeader extends StatefulWidget {
  final ShowItem showItem;

  const _InformationHeader({Key? key, required this.showItem})
      : super(key: key);

  @override
  __InformationHeaderState createState() => __InformationHeaderState();
}

class __InformationHeaderState extends State<_InformationHeader> {
  bool favorite = false;
  bool logged = false;
  int userId = -1;

  @override
  void initState() {
    context.read<GetLoggedBloc>().add(GetLoggedLoad());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _iconButton = Icons.arrow_back_ios_new;

    return MultiBlocListener(
      listeners: [
        BlocListener<AddFavoriteBloc, AddFavoriteState>(
          listener: (context, state) {
            if (state is AddFavoriteLoaded) {
              if (state.success) {
                setState(() {
                  favorite = true;
                });
              }
            }
          },
        ),
        BlocListener<RemoveFavoriteBloc, RemoveFavoriteState>(
          listener: (context, state) {
            if (state is RemoveFavoriteLoaded) {
              if (state.success) {
                setState(() {
                  favorite = false;
                });

                context.read<FavoriteListBloc>().add(
                      FavoriteListLoad(
                        userId,
                      ),
                    );
              }
            }
          },
        ),
        BlocListener<CheckFavoriteBloc, CheckFavoriteState>(
          listener: (context, state) {
            if (state is CheckFavoriteLoaded) {
              setState(() {
                favorite = state.checked;
              });

              context.read<FavoriteListBloc>().add(
                    FavoriteListLoad(
                      userId,
                    ),
                  );
            }
          },
        ),
        BlocListener<GetLoggedBloc, GetLoggedState>(
          listener: (context, state) async {
            if (state is GetLoggedLoaded) {
              logged = state.logged;
              userId = state.user.id;

              context.read<CheckFavoriteBloc>().add(
                    CheckFavoriteLoad(
                      FavoriteClass(
                        widget.showItem,
                        userId,
                      ),
                    ),
                  );
            }
          },
        ),
      ],
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Button(
              icon: _iconButton,
              fuction: () => Navigator.pop(context),
            ),
          ),
          Expanded(
            flex: 3,
            child: SizedBox(),
          ),
          Expanded(
            flex: 1,
            child: favorite ? _removeFavorite() : _addFavorite(),
          ),
        ],
      ),
    );
  }

  _addFavorite() {
    final _color = AppTheme().colors.backGround;
    final _iconColor = AppTheme().colors.highlight;
    final _icon = Icons.star_border;
    final _radius = 12.0;
    final _padding = 16.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Get same size to be square
          final squareSize = min(
            constraints.maxWidth,
            constraints.maxHeight,
          );

          return Container(
            height: squareSize,
            width: squareSize,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.all(
                Radius.circular(_radius),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (logged) {
                    context.read<AddFavoriteBloc>().add(
                          AddFavoriteLoad(
                            FavoriteClass(
                              widget.showItem,
                              userId,
                            ),
                          ),
                        );
                  } else {
                    CustomToast()
                        .errorToast("Sign in first!", ToastGravity.TOP);
                  }
                },
                borderRadius: BorderRadius.all(
                  Radius.circular(_radius),
                ),
                child: Icon(
                  _icon,
                  color: _iconColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _removeFavorite() {
    final _color = AppTheme().colors.base;
    final _iconColor = AppTheme().colors.dark;
    final _icon = Icons.star;
    final _radius = 12.0;
    final _padding = 16.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Get same size to be square
          final squareSize = min(
            constraints.maxWidth,
            constraints.maxHeight,
          );

          return Container(
            height: squareSize,
            width: squareSize,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.all(
                Radius.circular(_radius),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (logged) {
                    context.read<RemoveFavoriteBloc>().add(
                          RemoveFavoriteLoad(
                            FavoriteClass(
                              widget.showItem,
                              userId,
                            ),
                          ),
                        );
                  } else {
                    CustomToast()
                        .errorToast("Sign in first!", ToastGravity.TOP);
                  }
                },
                borderRadius: BorderRadius.all(
                  Radius.circular(_radius),
                ),
                child: Icon(
                  _icon,
                  color: _iconColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

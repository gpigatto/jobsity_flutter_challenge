import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/commands/add_favorite_command.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/commands/remove_favorite_command.dart';

abstract class RemoveFavoriteEvent extends Equatable {
  const RemoveFavoriteEvent();

  @override
  List<Object> get props => [];
}

class RemoveFavoriteLoad extends RemoveFavoriteEvent {
  final FavoriteClass favoriteClass;

  RemoveFavoriteLoad(this.favoriteClass);

  @override
  List<Object> get props => [];
}

class RemoveFavoriteBloc
    extends Bloc<RemoveFavoriteEvent, RemoveFavoriteState> {
  final RemoveFavoriteCommand cmd;

  RemoveFavoriteBloc(this.cmd) : super(RemoveFavoriteInitial());

  @override
  Stream<RemoveFavoriteState> mapEventToState(
    RemoveFavoriteEvent event,
  ) async* {
    if (event is RemoveFavoriteLoad) {
      try {
        yield RemoveFavoriteLoading();

        var r = await cmd.call(event.favoriteClass);

        yield RemoveFavoriteLoaded(r > 0);
      } catch (e) {
        yield RemoveFavoriteError();
      }
    }
  }
}

abstract class RemoveFavoriteState extends Equatable {
  const RemoveFavoriteState();
}

class RemoveFavoriteInitial extends RemoveFavoriteState {
  @override
  List<Object> get props => ['RemoveFavoriteInitial'];
}

class RemoveFavoriteLoading extends RemoveFavoriteState {
  @override
  List<Object> get props => ['RemoveFavoriteLoading'];
}

class RemoveFavoriteError extends RemoveFavoriteState {
  @override
  List<Object> get props => ['RemoveFavoriteError'];
}

class RemoveFavoriteLoaded extends RemoveFavoriteState {
  final bool success;

  RemoveFavoriteLoaded(this.success);

  @override
  List<Object> get props => [success];
}

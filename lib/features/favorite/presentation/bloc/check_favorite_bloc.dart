import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/commands/add_favorite_command.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/commands/check_favorite_command.dart';

abstract class CheckFavoriteEvent extends Equatable {
  const CheckFavoriteEvent();

  @override
  List<Object> get props => [];
}

class CheckFavoriteLoad extends CheckFavoriteEvent {
  final FavoriteClass favoriteClass;

  CheckFavoriteLoad(this.favoriteClass);

  @override
  List<Object> get props => [];
}

class CheckFavoriteBloc extends Bloc<CheckFavoriteEvent, CheckFavoriteState> {
  final CheckFavoriteCommand cmd;

  CheckFavoriteBloc(this.cmd) : super(CheckFavoriteInitial());

  @override
  Stream<CheckFavoriteState> mapEventToState(
    CheckFavoriteEvent event,
  ) async* {
    if (event is CheckFavoriteLoad) {
      try {
        yield CheckFavoriteLoading();

        var r = await cmd.call(event.favoriteClass);

        yield CheckFavoriteLoaded(r > 0);
      } catch (e) {
        yield CheckFavoriteError();
      }
    }
  }
}

abstract class CheckFavoriteState extends Equatable {
  const CheckFavoriteState();
}

class CheckFavoriteInitial extends CheckFavoriteState {
  @override
  List<Object> get props => ['CheckFavoriteInitial'];
}

class CheckFavoriteLoading extends CheckFavoriteState {
  @override
  List<Object> get props => ['CheckFavoriteLoading'];
}

class CheckFavoriteError extends CheckFavoriteState {
  @override
  List<Object> get props => ['CheckFavoriteError'];
}

class CheckFavoriteLoaded extends CheckFavoriteState {
  final bool checked;

  CheckFavoriteLoaded(this.checked);

  @override
  List<Object> get props => [checked];
}

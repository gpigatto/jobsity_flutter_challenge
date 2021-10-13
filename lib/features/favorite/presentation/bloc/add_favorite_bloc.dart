import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/commands/add_favorite_command.dart';

abstract class AddFavoriteEvent extends Equatable {
  const AddFavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddFavoriteLoad extends AddFavoriteEvent {
  final FavoriteClass addFavoriteClass;

  AddFavoriteLoad(this.addFavoriteClass);

  @override
  List<Object> get props => [];
}

class AddFavoriteBloc extends Bloc<AddFavoriteEvent, AddFavoriteState> {
  final AddFavoriteCommand cmd;

  AddFavoriteBloc(this.cmd) : super(AddFavoriteInitial());

  @override
  Stream<AddFavoriteState> mapEventToState(
    AddFavoriteEvent event,
  ) async* {
    if (event is AddFavoriteLoad) {
      try {
        yield AddFavoriteLoading();

        var r = await cmd.call(event.addFavoriteClass);

        yield AddFavoriteLoaded(r > 0);
      } catch (e) {
        yield AddFavoriteError();
      }
    }
  }
}

abstract class AddFavoriteState extends Equatable {
  const AddFavoriteState();
}

class AddFavoriteInitial extends AddFavoriteState {
  @override
  List<Object> get props => ['AddFavoriteInitial'];
}

class AddFavoriteLoading extends AddFavoriteState {
  @override
  List<Object> get props => ['AddFavoriteLoading'];
}

class AddFavoriteError extends AddFavoriteState {
  @override
  List<Object> get props => ['AddFavoriteError'];
}

class AddFavoriteLoaded extends AddFavoriteState {
  final bool success;

  AddFavoriteLoaded(this.success);

  @override
  List<Object> get props => [success];
}

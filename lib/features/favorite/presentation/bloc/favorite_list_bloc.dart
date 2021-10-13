import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/favorite/domain/commands/favorite_list_command.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/widgets/feed_body.dart';

abstract class FavoriteListEvent extends Equatable {
  const FavoriteListEvent();

  @override
  List<Object> get props => [];
}

class FavoriteListLoad extends FavoriteListEvent {
  final int userId;

  FavoriteListLoad(this.userId);

  @override
  List<Object> get props => [];
}

class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {
  final FavoriteListCommand cmd;

  FavoriteListBloc(this.cmd) : super(FavoriteListInitial());

  @override
  Stream<FavoriteListState> mapEventToState(
    FavoriteListEvent event,
  ) async* {
    if (event is FavoriteListLoad) {
      try {
        yield FavoriteListLoading();

        var r = await cmd.call(event.userId);

        yield FavoriteListLoaded(r);
      } catch (e) {
        yield FavoriteListError();
      }
    }
  }
}

abstract class FavoriteListState extends Equatable {
  const FavoriteListState();
}

class FavoriteListInitial extends FavoriteListState {
  @override
  List<Object> get props => ['FavoriteListInitial'];
}

class FavoriteListLoading extends FavoriteListState {
  @override
  List<Object> get props => ['FavoriteListLoading'];
}

class FavoriteListError extends FavoriteListState {
  @override
  List<Object> get props => ['FavoriteListError'];
}

class FavoriteListLoaded extends FavoriteListState {
  final List<ShowItem> list;

  FavoriteListLoaded(this.list);

  @override
  List<Object> get props => [list];
}

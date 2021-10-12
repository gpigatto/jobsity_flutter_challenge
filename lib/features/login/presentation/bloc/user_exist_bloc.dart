import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/user_exist_interface.dart';

abstract class UserExistEvent extends Equatable {
  const UserExistEvent();

  @override
  List<Object> get props => [];
}

class UserExistLoad extends UserExistEvent {
  final String username;

  UserExistLoad(this.username);

  @override
  List<Object> get props => [];
}

class UserExistBloc extends Bloc<UserExistEvent, UserExistState> {
  final UserExistCommand cmd;

  UserExistBloc(this.cmd) : super(UserExistInitial());

  @override
  Stream<UserExistState> mapEventToState(
    UserExistEvent event,
  ) async* {
    if (event is UserExistLoad) {
      try {
        yield UserExistLoading();

        var r = await cmd.call(event.username);

        yield UserExistLoaded(r);
      } catch (e) {
        yield UserExistError();
      }
    }
  }
}

abstract class UserExistState extends Equatable {
  const UserExistState();
}

class UserExistInitial extends UserExistState {
  @override
  List<Object> get props => ['UserExistInitial'];
}

class UserExistLoading extends UserExistState {
  @override
  List<Object> get props => ['UserExistLoading'];
}

class UserExistError extends UserExistState {
  @override
  List<Object> get props => ['UserExistError'];
}

class UserExistLoaded extends UserExistState {
  final bool exist;

  UserExistLoaded(this.exist);

  @override
  List<Object> get props => [exist];
}

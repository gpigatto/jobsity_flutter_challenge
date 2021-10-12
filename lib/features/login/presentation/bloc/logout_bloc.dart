import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/logout_command.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

class LogoutLoad extends LogoutEvent {
  @override
  List<Object> get props => [];
}

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutCommand cmd;

  LogoutBloc(this.cmd) : super(LogoutInitial());

  @override
  Stream<LogoutState> mapEventToState(
    LogoutEvent event,
  ) async* {
    if (event is LogoutLoad) {
      try {
        yield LogoutLoading();

        var r = await cmd.call(null);

        yield LogoutLoaded(r);
      } catch (e) {
        yield LogoutError();
      }
    }
  }
}

abstract class LogoutState extends Equatable {
  const LogoutState();
}

class LogoutInitial extends LogoutState {
  @override
  List<Object> get props => ['LogoutInitial'];
}

class LogoutLoading extends LogoutState {
  @override
  List<Object> get props => ['LogoutLoading'];
}

class LogoutError extends LogoutState {
  @override
  List<Object> get props => ['LogoutError'];
}

class LogoutLoaded extends LogoutState {
  final bool success;

  LogoutLoaded(this.success);

  @override
  List<Object> get props => [success];
}

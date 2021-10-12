import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/login_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/register_command.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginLoad extends LoginEvent {
  final LoginClass login;

  LoginLoad(this.login);

  @override
  List<Object> get props => [];
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginCommand cmd;

  LoginBloc(this.cmd) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginLoad) {
      try {
        yield LoginLoading();

        var r = await cmd.call(event.login);

        yield LoginLoaded(r > 0);
      } catch (e) {
        yield LoginError();
      }
    }
  }
}

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => ['LoginInitial'];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => ['LoginLoading'];
}

class LoginError extends LoginState {
  @override
  List<Object> get props => ['LoginError'];
}

class LoginLoaded extends LoginState {
  final bool correct;

  LoginLoaded(this.correct);

  @override
  List<Object> get props => [correct];
}

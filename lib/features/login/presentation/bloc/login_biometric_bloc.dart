import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/login_biometric_interface.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/register_command.dart';

abstract class LoginBiometricEvent extends Equatable {
  const LoginBiometricEvent();

  @override
  List<Object> get props => [];
}

class LoginBiometricLoad extends LoginBiometricEvent {
  final String username;

  LoginBiometricLoad(this.username);

  @override
  List<Object> get props => [];
}

class LoginBiometricBloc
    extends Bloc<LoginBiometricEvent, LoginBiometricState> {
  final LoginBiometricCommand cmd;

  LoginBiometricBloc(this.cmd) : super(LoginBiometricInitial());

  @override
  Stream<LoginBiometricState> mapEventToState(
    LoginBiometricEvent event,
  ) async* {
    if (event is LoginBiometricLoad) {
      try {
        yield LoginBiometricLoading();

        var r = await cmd.call(event.username);

        yield LoginBiometricLoaded(r);
      } catch (e) {
        yield LoginBiometricError();
      }
    }
  }
}

abstract class LoginBiometricState extends Equatable {
  const LoginBiometricState();
}

class LoginBiometricInitial extends LoginBiometricState {
  @override
  List<Object> get props => ['LoginBiometricInitial'];
}

class LoginBiometricLoading extends LoginBiometricState {
  @override
  List<Object> get props => ['LoginBiometricLoading'];
}

class LoginBiometricError extends LoginBiometricState {
  @override
  List<Object> get props => ['LoginBiometricError'];
}

class LoginBiometricLoaded extends LoginBiometricState {
  final LoginClass login_information;

  LoginBiometricLoaded(this.login_information);

  @override
  List<Object> get props => [login_information];
}

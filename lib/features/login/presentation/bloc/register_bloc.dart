import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/register_command.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterLoad extends RegisterEvent {
  final LoginClass login;

  RegisterLoad(this.login);

  @override
  List<Object> get props => [];
}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterCommand cmd;

  RegisterBloc(this.cmd) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterLoad) {
      try {
        yield RegisterLoading();

        var r = await cmd.call(event.login);

        yield RegisterLoaded(r);
      } catch (e) {
        yield RegisterError();
      }
    }
  }
}

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => ['RegisterInitial'];
}

class RegisterLoading extends RegisterState {
  @override
  List<Object> get props => ['RegisterLoading'];
}

class RegisterError extends RegisterState {
  @override
  List<Object> get props => ['RegisterError'];
}

class RegisterLoaded extends RegisterState {
  final int id;

  RegisterLoaded(this.id);

  @override
  List<Object> get props => [id];
}

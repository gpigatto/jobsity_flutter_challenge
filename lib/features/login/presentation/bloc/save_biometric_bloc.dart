import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/register_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/save_biometric_command.dart';

abstract class SaveBiometricEvent extends Equatable {
  const SaveBiometricEvent();

  @override
  List<Object> get props => [];
}

class SaveBiometricLoad extends SaveBiometricEvent {
  final LoginClass login;

  SaveBiometricLoad(this.login);

  @override
  List<Object> get props => [];
}

class SaveBiometricBloc extends Bloc<SaveBiometricEvent, SaveBiometricState> {
  final SaveBiometricCommand cmd;

  SaveBiometricBloc(this.cmd) : super(SaveBiometricInitial());

  @override
  Stream<SaveBiometricState> mapEventToState(
    SaveBiometricEvent event,
  ) async* {
    if (event is SaveBiometricLoad) {
      try {
        yield SaveBiometricLoading();

        var r = await cmd.call(event.login);

        yield SaveBiometricLoaded(r);
      } catch (e) {
        yield SaveBiometricError();
      }
    }
  }
}

abstract class SaveBiometricState extends Equatable {
  const SaveBiometricState();
}

class SaveBiometricInitial extends SaveBiometricState {
  @override
  List<Object> get props => ['SaveBiometricInitial'];
}

class SaveBiometricLoading extends SaveBiometricState {
  @override
  List<Object> get props => ['SaveBiometricLoading'];
}

class SaveBiometricError extends SaveBiometricState {
  @override
  List<Object> get props => ['SaveBiometricError'];
}

class SaveBiometricLoaded extends SaveBiometricState {
  final bool success;

  SaveBiometricLoaded(this.success);

  @override
  List<Object> get props => [success];
}

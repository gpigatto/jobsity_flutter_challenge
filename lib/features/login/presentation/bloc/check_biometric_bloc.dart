import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/check_biometric_command.dart';

abstract class CheckBiometricEvent extends Equatable {
  const CheckBiometricEvent();

  @override
  List<Object> get props => [];
}

class CheckBiometricLoad extends CheckBiometricEvent {
  final String user;

  CheckBiometricLoad(this.user);

  @override
  List<Object> get props => [];
}

class CheckBiometricBloc
    extends Bloc<CheckBiometricEvent, CheckBiometricState> {
  final CheckBiometricCommand cmd;

  CheckBiometricBloc(this.cmd) : super(CheckBiometricInitial());

  @override
  Stream<CheckBiometricState> mapEventToState(
    CheckBiometricEvent event,
  ) async* {
    if (event is CheckBiometricLoad) {
      try {
        yield CheckBiometricLoading();

        var r = await cmd.call(event.user);

        yield CheckBiometricLoaded(r);
      } catch (e) {
        yield CheckBiometricError();
      }
    }
  }
}

abstract class CheckBiometricState extends Equatable {
  const CheckBiometricState();
}

class CheckBiometricInitial extends CheckBiometricState {
  @override
  List<Object> get props => ['CheckBiometricInitial'];
}

class CheckBiometricLoading extends CheckBiometricState {
  @override
  List<Object> get props => ['CheckBiometricLoading'];
}

class CheckBiometricError extends CheckBiometricState {
  @override
  List<Object> get props => ['CheckBiometricError'];
}

class CheckBiometricLoaded extends CheckBiometricState {
  final CheckBiometricClass checkBiometricClass;

  CheckBiometricLoaded(this.checkBiometricClass);

  @override
  List<Object> get props => [checkBiometricClass];
}

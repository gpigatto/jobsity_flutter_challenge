import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/get_logged_command.dart';

abstract class GetLoggedEvent extends Equatable {
  const GetLoggedEvent();

  @override
  List<Object> get props => [];
}

class GetLoggedLoad extends GetLoggedEvent {
  @override
  List<Object> get props => [];
}

class GetLoggedBloc extends Bloc<GetLoggedEvent, GetLoggedState> {
  final GetLoggedCommand cmd;

  GetLoggedBloc(this.cmd) : super(GetLoggedInitial());

  @override
  Stream<GetLoggedState> mapEventToState(
    GetLoggedEvent event,
  ) async* {
    if (event is GetLoggedLoad) {
      try {
        yield GetLoggedLoading();

        var r = await cmd.call(null);

        yield GetLoggedLoaded(r.id > 0, r);
      } catch (e) {
        yield GetLoggedError();
      }
    }
  }
}

abstract class GetLoggedState extends Equatable {
  const GetLoggedState();
}

class GetLoggedInitial extends GetLoggedState {
  @override
  List<Object> get props => ['GetLoggedInitial'];
}

class GetLoggedLoading extends GetLoggedState {
  @override
  List<Object> get props => ['GetLoggedLoading'];
}

class GetLoggedError extends GetLoggedState {
  @override
  List<Object> get props => ['GetLoggedError'];
}

class GetLoggedLoaded extends GetLoggedState {
  final bool logged;
  final LoggedClass user;

  GetLoggedLoaded(this.logged, this.user);

  @override
  List<Object> get props => [logged, user];
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/feed/domain/commands/feed_command.dart';
import 'package:jobsity_flutter_challenge/features/feed/model/feed_model.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class FeedLoad extends FeedEvent {
  final int page;

  FeedLoad(this.page);

  @override
  List<Object> get props => [];
}

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedCommand cmd;

  FeedBloc(this.cmd) : super(FeedInitial());

  @override
  Stream<FeedState> mapEventToState(
    FeedEvent event,
  ) async* {
    if (event is FeedLoad) {
      try {
        yield FeedLoading();

        var r = await cmd.call(event.page);

        yield FeedLoaded(r);
      } catch (e) {
        yield FeedError();
      }
    }
  }
}

abstract class FeedState extends Equatable {
  const FeedState();
}

class FeedInitial extends FeedState {
  @override
  List<Object> get props => ['FeedInitial'];
}

class FeedLoading extends FeedState {
  @override
  List<Object> get props => ['FeedLoading'];
}

class FeedError extends FeedState {
  @override
  List<Object> get props => ['FeedError'];
}

class FeedLoaded extends FeedState {
  final FeedModel feedModel;

  FeedLoaded(this.feedModel);

  @override
  List<Object> get props => [feedModel];
}

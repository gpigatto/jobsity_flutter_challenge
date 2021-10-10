import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/information/domain/commands/episode_list_command.dart';
import 'package:jobsity_flutter_challenge/features/information/model/episode_list_model.dart';

abstract class EpisodeListEvent extends Equatable {
  const EpisodeListEvent();

  @override
  List<Object> get props => [];
}

class EpisodeListLoad extends EpisodeListEvent {
  final int page;

  EpisodeListLoad(this.page);

  @override
  List<Object> get props => [];
}

class EpisodeListBloc extends Bloc<EpisodeListEvent, EpisodeListState> {
  final EpisodeListCommand cmd;

  EpisodeListBloc(this.cmd) : super(EpisodeListInitial());

  @override
  Stream<EpisodeListState> mapEventToState(
    EpisodeListEvent event,
  ) async* {
    if (event is EpisodeListLoad) {
      try {
        yield EpisodeListLoading();

        var r = cmd.groupBySeason(await cmd.call(event.page));

        yield EpisodeListGroupedBySeason(r);
      } catch (e) {
        yield EpisodeListError();
      }
    }
  }
}

abstract class EpisodeListState extends Equatable {
  const EpisodeListState();
}

class EpisodeListInitial extends EpisodeListState {
  @override
  List<Object> get props => ['EpisodeListInitial'];
}

class EpisodeListLoading extends EpisodeListState {
  @override
  List<Object> get props => ['EpisodeListLoading'];
}

class EpisodeListError extends EpisodeListState {
  @override
  List<Object> get props => ['EpisodeListError'];
}

class EpisodeListLoaded extends EpisodeListState {
  final EpisodeListModel episodeListModel;

  EpisodeListLoaded(this.episodeListModel);

  @override
  List<Object> get props => [episodeListModel];
}

class EpisodeListGroupedBySeason extends EpisodeListState {
  final Map<int?, List<EpisodeListModelObjectList>> grouped;

  EpisodeListGroupedBySeason(this.grouped);

  @override
  List<Object> get props => [grouped];
}

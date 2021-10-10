import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_flutter_challenge/features/search/domain/commands/search_show_command.dart';
import 'package:jobsity_flutter_challenge/features/search/model/search_show_model.dart';

abstract class SearchShowEvent extends Equatable {
  const SearchShowEvent();

  @override
  List<Object> get props => [];
}

class SearchShowLoad extends SearchShowEvent {
  final String query;

  SearchShowLoad(this.query);

  @override
  List<Object> get props => [];
}

class SearchShowBloc extends Bloc<SearchShowEvent, SearchShowState> {
  final SearchShowCommand cmd;

  SearchShowBloc(this.cmd) : super(SearchShowInitial());

  @override
  Stream<SearchShowState> mapEventToState(
    SearchShowEvent event,
  ) async* {
    if (event is SearchShowLoad) {
      try {
        yield SearchShowLoading();

        var r = await cmd.call(event.query);

        yield SearchShowLoaded(r);
      } catch (e) {
        yield SearchShowError();
      }
    }
  }
}

abstract class SearchShowState extends Equatable {
  const SearchShowState();
}

class SearchShowInitial extends SearchShowState {
  @override
  List<Object> get props => ['SearchShowInitial'];
}

class SearchShowLoading extends SearchShowState {
  @override
  List<Object> get props => ['SearchShowLoading'];
}

class SearchShowError extends SearchShowState {
  @override
  List<Object> get props => ['SearchShowError'];
}

class SearchShowLoaded extends SearchShowState {
  final SearchShowModel searchShowModel;

  SearchShowLoaded(this.searchShowModel);

  @override
  List<Object> get props => [searchShowModel];
}

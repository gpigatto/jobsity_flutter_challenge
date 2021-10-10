import 'package:get_it/get_it.dart';
import 'package:jobsity_flutter_challenge/features/feed/data/feed_data.dart';
import 'package:jobsity_flutter_challenge/features/feed/domain/commands/feed_command.dart';
import 'package:jobsity_flutter_challenge/features/feed/domain/repository/feed_interface.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:jobsity_flutter_challenge/features/information/data/episode_list_data.dart';
import 'package:jobsity_flutter_challenge/features/information/domain/commands/episode_list_command.dart';
import 'package:jobsity_flutter_challenge/features/information/domain/repository/episodes_interface.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/bloc/episodes_list_bloc.dart';
import 'package:jobsity_flutter_challenge/features/search/data/search_show_data.dart';
import 'package:jobsity_flutter_challenge/features/search/domain/commands/search_show_command.dart';
import 'package:jobsity_flutter_challenge/features/search/domain/repository/search_show_interface.dart';
import 'package:jobsity_flutter_challenge/features/search/presentation/bloc/search_show_bloc.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  await _feed();
  await _episodeList();
  await _searchShow();
}

Future<void> _feed() async {
  //repositorio / acesso aos dados
  serviceLocator.registerLazySingleton<FeedInterface>(() => FeedData());
  //command / regra de negocio
  serviceLocator.registerLazySingleton(() => FeedCommand(serviceLocator()));
  //bloc / estado
  serviceLocator.registerFactory(() => FeedBloc(serviceLocator()));
}

Future<void> _episodeList() async {
  //repositorio / acesso aos dados
  serviceLocator
      .registerLazySingleton<EpisodeListInterface>(() => EpisodeListData());
  //command / regra de negocio
  serviceLocator
      .registerLazySingleton(() => EpisodeListCommand(serviceLocator()));
  //bloc / estado
  serviceLocator.registerFactory(() => EpisodeListBloc(serviceLocator()));
}

Future<void> _searchShow() async {
  //repositorio / acesso aos dados
  serviceLocator
      .registerLazySingleton<SearchShowInterface>(() => SearchShowData());
  //command / regra de negocio
  serviceLocator
      .registerLazySingleton(() => SearchShowCommand(serviceLocator()));
  //bloc / estado
  serviceLocator.registerFactory(() => SearchShowBloc(serviceLocator()));
}

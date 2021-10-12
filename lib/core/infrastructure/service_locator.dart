import 'package:get_it/get_it.dart';
import 'package:jobsity_flutter_challenge/features/feed/data/feed_data.dart';
import 'package:jobsity_flutter_challenge/features/feed/domain/commands/feed_command.dart';
import 'package:jobsity_flutter_challenge/features/feed/domain/repository/feed_interface.dart';
import 'package:jobsity_flutter_challenge/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:jobsity_flutter_challenge/features/information/data/episode_list_data.dart';
import 'package:jobsity_flutter_challenge/features/information/domain/commands/episode_list_command.dart';
import 'package:jobsity_flutter_challenge/features/information/domain/repository/episodes_interface.dart';
import 'package:jobsity_flutter_challenge/features/information/presentation/bloc/episodes_list_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/data/get_logged_data.dart';
import 'package:jobsity_flutter_challenge/features/login/data/login_data.dart';
import 'package:jobsity_flutter_challenge/features/login/data/logout_data.dart';
import 'package:jobsity_flutter_challenge/features/login/data/register_data.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/get_logged_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/login_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/logout_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/register_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/get_logged_interface.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/login_interface.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/logout_interface.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/repository/register_interface.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/get_logged_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/login_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/logout_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/register_bloc.dart';
import 'package:jobsity_flutter_challenge/features/search/data/search_show_data.dart';
import 'package:jobsity_flutter_challenge/features/search/domain/commands/search_show_command.dart';
import 'package:jobsity_flutter_challenge/features/search/domain/repository/search_show_interface.dart';
import 'package:jobsity_flutter_challenge/features/search/presentation/bloc/search_show_bloc.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  await _feed();
  await _episodeList();
  await _searchShow();
  await _register();
  await _login();
  await _getLogged();
  await _logout();
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

Future<void> _register() async {
  //repositorio / acesso aos dados
  serviceLocator.registerLazySingleton<RegisterInterface>(() => RegisterData());
  //command / regra de negocio
  serviceLocator.registerLazySingleton(() => RegisterCommand(serviceLocator()));
  //bloc / estado
  serviceLocator.registerFactory(() => RegisterBloc(serviceLocator()));
}

Future<void> _login() async {
  //repositorio / acesso aos dados
  serviceLocator.registerLazySingleton<LoginInterface>(() => LoginData());
  //command / regra de negocio
  serviceLocator.registerLazySingleton(() => LoginCommand(serviceLocator()));
  //bloc / estado
  serviceLocator.registerFactory(() => LoginBloc(serviceLocator()));
}

Future<void> _getLogged() async {
  //repositorio / acesso aos dados
  serviceLocator
      .registerLazySingleton<GetLoggedInterface>(() => GetLoggedData());
  //command / regra de negocio
  serviceLocator
      .registerLazySingleton(() => GetLoggedCommand(serviceLocator()));
  //bloc / estado
  serviceLocator.registerFactory(() => GetLoggedBloc(serviceLocator()));
}

Future<void> _logout() async {
  //repositorio / acesso aos dados
  serviceLocator.registerLazySingleton<LogoutInterface>(() => LogoutData());
  //command / regra de negocio
  serviceLocator.registerLazySingleton(() => LogoutCommand(serviceLocator()));
  //bloc / estado
  serviceLocator.registerFactory(() => LogoutBloc(serviceLocator()));
}

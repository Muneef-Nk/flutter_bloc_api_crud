import 'package:bloc_clean_crud/features/user_create_update/data/service/user_update_create_service.dart';
import 'package:bloc_clean_crud/features/user_create_update/presentation/bloc/user_update_create_bloc.dart';
import 'package:bloc_clean_crud/features/user_details/presentation/bloc/user_details_bloc.dart';
import 'package:bloc_clean_crud/features/user_list/presentation/bloc/user_list_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/user_create_update/data/repositories/user_update_create_repository_impl.dart';
import '../../features/user_create_update/domain/repositories/user_update_create_repository.dart';
import '../../features/user_create_update/domain/usecases/create_user.dart';
import '../../features/user_create_update/domain/usecases/delete_user.dart';
import '../../features/user_create_update/domain/usecases/update_user.dart';

import '../../features/user_list/data/service/get_user_service.dart';
import '../../features/user_list/data/repositories/user_list_repository_impl.dart';
import '../../features/user_list/domain/repositories/user_list_repository.dart';
import '../../features/user_list/domain/usecases/get_user_list.dart';

import '../../features/user_details/data/service/user_details_service.dart';
import '../../features/user_details/data/repositories/user_details_repository_impl.dart';
import '../../features/user_details/domain/repositories/user_details_repository.dart';
import '../../features/user_details/domain/usecases/get_user_details.dart';

final di = GetIt.instance;

Future<void> setupLocator() async {
  // User List
  di.registerLazySingleton<UserListService>(() => UserListServiceImpl());
  di.registerLazySingleton<UserListRepository>(() => UserListRepositoryImpl(di()));
  di.registerLazySingleton(() => GetUserList(di()));

  // User Details
  di.registerLazySingleton<UserDetailsService>(() => UserDetailsServiceImpl());
  di.registerLazySingleton<UserDetailsRepository>(() => UserDetailsRepositoryImpl(di()));
  di.registerLazySingleton(() => GetUserDetails(di()));

  // User Update/Create
  di.registerLazySingleton<UserUpdateCreateService>(() => UserUpdateCreateServiceImpl());
  di.registerLazySingleton<UserUpdateCreateRepository>(() => UserUpdateCreateRepositoryImpl(di()));
  di.registerLazySingleton(() => CreateUser(di()));
  di.registerLazySingleton(() => UpdateUser(di()));
  di.registerLazySingleton(() => DeleteUser(di()));

  di.registerFactory(() => UserListBloc(di()));
  di.registerFactory(() => UserDetailsBloc(di()));
  di.registerFactory(
    () => UserUpdateCreateBloc(createUser: di(), updateUser: di(), deleteUser: di()),
  );
}

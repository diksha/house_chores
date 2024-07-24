import 'package:get_it/get_it.dart';
import 'package:house_chores/core/common/cubits/cubits/app_user/app_user_cubit.dart';
import 'package:house_chores/core/secrets/app_secrets.dart';
import 'package:house_chores/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:house_chores/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:house_chores/features/auth/domain/repository/auth_repository.dart';
import 'package:house_chores/features/auth/domain/usecases/current_user.dart';
import 'package:house_chores/features/auth/domain/usecases/user_login.dart';
import 'package:house_chores/features/auth/domain/usecases/user_sign_up.dart';
import 'package:house_chores/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> init_dependencies() async {
  _initAuth();

  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.anonKey);
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator<SupabaseClient>()));
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator<AuthRemoteDataSource>()));
  serviceLocator.registerFactory<UserSignUp>(
      () => UserSignUp(serviceLocator<AuthRepository>()));
  serviceLocator.registerFactory<UserLogin>(
      () => UserLogin(serviceLocator<AuthRepository>()));
  serviceLocator.registerFactory<CurrentUser>(
      () => CurrentUser(serviceLocator<AuthRepository>()));
  serviceLocator.registerLazySingleton<AppUserCubit>(() => AppUserCubit());
  serviceLocator.registerLazySingleton<AuthBloc>(() => AuthBloc(
      userSignUp: serviceLocator<UserSignUp>(),
      userLogin: serviceLocator<UserLogin>(),
      currentUser: serviceLocator<CurrentUser>(),
      appUserCubit: serviceLocator<AppUserCubit>()));
}

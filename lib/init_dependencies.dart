import 'package:get_it/get_it.dart';
import 'package:house_chores/core/secrets/app_secrets.dart';
import 'package:house_chores/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:house_chores/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:house_chores/features/auth/domain/repository/auth_repository.dart';
import 'package:house_chores/features/auth/domain/usercases/user_sign_up.dart';
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
  serviceLocator.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(serviceLocator<SupabaseClient>() ));
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory<UserSignUp>(() => UserSignUp(serviceLocator()));
  serviceLocator.registerLazySingleton<AuthBloc>(() => AuthBloc(userSignUp: serviceLocator()));
}
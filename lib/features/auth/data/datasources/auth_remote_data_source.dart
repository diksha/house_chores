import 'package:house_chores/core/error/exceptions.dart';
import 'package:house_chores/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailPassword(
      {required String email, required String password});
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password});
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<UserModel> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      print('Entering here');
      final authResponse =
          await supabaseClient.auth.signUp(password: password, email: email);
      print('authResponse ${authResponse}');
      if (authResponse.user == null) {
        throw const ServerException('User is null');
      }
      return UserModel.fromJson(authResponse.user!.toJson())
          .copyWith(email: authResponse.user!.email);
    } catch (e) {
      print(e);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      print('Entering here');
      final authResponse = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);
      print('authResponse ${authResponse}');
      if (authResponse.user == null) {
        throw const ServerException('User is null');
      }
      return UserModel.fromJson(authResponse.user!.toJson())
          .copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      print(e);
      throw ServerException(e.toString());
    }
  }

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(userData.first)
            .copyWith(email: currentUserSession!.user.email);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

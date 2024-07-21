import 'package:house_chores/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPassword(
      {required String email, required String password});
  Future<String> loginWithEmailPassword(
      {required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<String> signUpWithEmailPassword(
      {required String email, required String password}) async {

    try {
      final authResponse = await supabaseClient.auth.signUp(
          password: password, email: email);
      if (authResponse.user == null) {
        throw const ServerException('User is null');
      }
      return authResponse.user!.id;
    } catch(e) {
      throw ServerException(e.toString());
    }
    return Future.value('Value');
  }

  @override
  Future<String> loginWithEmailPassword(
      {required String email, required String password}) {
    return Future.value('Value');
  }
}

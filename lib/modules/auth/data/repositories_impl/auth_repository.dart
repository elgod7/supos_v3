import 'package:supos_v3/database/local_database.dart' as localDb;
import '../datasources/local_auth.dart';
import '../datasources/remote_auth.dart';

class AuthRepository {
  final LocalAuth localAuth;
  final RemoteAuth remoteAuth;

  AuthRepository({required this.localAuth, required this.remoteAuth});

  Future<localDb.User?> signIn(
      {required String email, required String password}) async {
    final remoteUser =
        await remoteAuth.signIn(email: email, password: password);
    final accessToken = remoteAuth.getCurrentSession()?.accessToken;
    if (remoteUser != null && accessToken != null) {
      final localUser = localDb.User(
        id: remoteUser.id,
        email: remoteUser.email ?? '',
        token: accessToken,
        lastLogin: DateTime.now(),
      );

      await localAuth.insertUser(localUser);

      return localUser;
    }

    return null;
  }

  Future<localDb.User?> signUp(
      {required String email, required String password}) async {
    final remoteUser =
        await remoteAuth.signUp(email: email, password: password);
    final accessToken = remoteAuth.getCurrentSession()?.accessToken;

    if (remoteUser != null) {
      final localUser = localDb.User(
        id: remoteUser.id,
        email: remoteUser.email ?? '',
        token: accessToken,
        lastLogin: DateTime.now(),
      );

      await localAuth.insertUser(localUser);

      return localUser;
    }

    return null;
  }

  Future<void> signOut(String userId) async {
    try {
      await remoteAuth.signOut();
    } finally {
      await localAuth.deleteUser(userId);
    }
  }

  Future<localDb.User?> getCurrentUser() async {
    final remoteUser = remoteAuth.getCurrentUser();

    if (remoteUser != null) {
      final localUser = await localAuth.getUser(remoteUser.id);
      return localUser;
    }
    return null;
  }

  Future<localDb.User?> getCurrentSession() async {
    return await localAuth.getLastLoginUser();
  }
}

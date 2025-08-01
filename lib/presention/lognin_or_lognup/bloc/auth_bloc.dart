import 'package:spotify_app/model/users_model.dart';
import 'package:spotify_app/repositories/auth_repositories.dart';

class AuthBloc {
  final _authReposi = AuthRepositories();
  UsersModel? currentUser;

  Future<bool> register(String email, String password, String name) async {
    final user = await _authReposi.signUp(email, password, name);
    if (user != null) {
      currentUser = user;
      return true;
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    final user = await _authReposi.login(email, password);
    if (user != null) {
      currentUser = user;
      return true;
    }
    return false;
  }

  void logout() async {
    await _authReposi.logout();
    currentUser = null;
  }
}

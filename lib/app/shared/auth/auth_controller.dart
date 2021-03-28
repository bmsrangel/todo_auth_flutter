import '../services/local_storage_service.dart';
import '../user_model.dart';
import 'repositories/auth_repository.dart';

class AuthController {
  AuthController(this._storageService, this._authRepository);

  final LocalStorageService _storageService;
  final AuthRepository _authRepository;

  UserModel user;

  Future<void> getUserData() async {
    final UserModel userData = await _storageService.getUserData();
    user = userData;
  }

  Future<void> login(String email, String password) async {
    this.user = await _authRepository.login(email, password);
    await _storageService.storeUserData(user);
  }

  Future<void> logout() async {
    await _storageService.clearUserData();
    user = null;
  }

  Future<void> register(String name, String email, String password) async {
    await _authRepository.register(name, email, password);
  }

  Future<void> refreshAccessToken() async {
    final String newToken =
        await _authRepository.refreshToken(user?.accessToken);
    user.accessToken = newToken;
    _storageService.storeUserData(user);
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/auth/auth_controller.dart';
import '../../shared/services/local_storage_service.dart';
import '../../shared/user_model.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';

class SplashCubit extends Cubit<int> {
  SplashCubit(this._storageService, this._auth$) : super(0);

  final LocalStorageService _storageService;
  final AuthController _auth$;

  Future<void> getUserData() async {
    final UserModel user = await _storageService.getUserData();
    if (user != null) {
      _auth$.user = user;
      Modular.to.navigate(HomePage.route, replaceAll: true);
    } else {
      Modular.to.navigate(LoginPage.route, replaceAll: true);
    }
  }
}

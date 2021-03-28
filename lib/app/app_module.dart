import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'modules/home/home_page.dart';
import 'modules/login/login_module.dart';
import 'modules/login/login_page.dart';
import 'modules/splash/splash_module.dart';
import 'shared/auth/auth_controller.dart';
import 'shared/auth/repositories/auth_repository.dart';
import 'shared/custom_dio/custom_dio.dart';
import 'shared/services/local_storage_service.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => CustomDio()),
    Bind.singleton((i) => CustomDioWeb()),
    Bind.lazySingleton((i) => AuthRepository()),
    Bind.singleton((i) => LocalStorageService()),
    Bind.singleton((i) => AuthController(
          i.get<LocalStorageService>(),
          i.get<AuthRepository>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
    ModuleRoute(LoginPage.route, module: LoginModule()),
    ModuleRoute(HomePage.route, module: HomeModule()),
  ];
}

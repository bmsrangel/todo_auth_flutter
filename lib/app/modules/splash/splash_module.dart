import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/auth/auth_controller.dart';
import '../../shared/services/local_storage_service.dart';
import 'splash_cubit.dart';
import 'splash_page.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashCubit(
          i.get<LocalStorageService>(),
          i.get<AuthController>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => SplashPage(),
    )
  ];
}

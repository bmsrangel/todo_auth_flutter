import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/custom_dio/custom_dio.dart';
import 'home_page.dart';
import 'repositories/todos_repository.dart';
import 'todos_cubit.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => TodosRepository(
        kIsWeb ? Modular.get<CustomDioWeb>() : Modular.get<CustomDio>())),
    Bind.lazySingleton((i) => TodosCubit(
          i.get<TodosRepository>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => HomePage()),
  ];
}

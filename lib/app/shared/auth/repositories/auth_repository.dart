import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_auth/app/shared/exceptions/validation_failed_exception.dart';

import '../../custom_dio/custom_dio.dart';
import '../../user_model.dart';

class AuthRepository {
  final Dio _client =
      kIsWeb ? Modular.get<CustomDioWeb>() : Modular.get<CustomDio>();

  Future<UserModel> login(String email, String password) async {
    Map<String, String> data = {
      'email': email,
      'password': password,
    };

    try {
      final Response response = await _client.post('/auth/login', data: data);
      return UserModel.fromMap(response.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 422) {
        throw ValidationFailedException(e.message);
      } else {
        throw e;
      }
    }
  }

  Future<void> register(String name, String email, String password) async {
    Map<String, String> data = {
      'name': name,
      'email': email,
      'password': password,
    };

    await _client.post('/users/register', data: data);
  }

  Future<String> refreshToken(String token) async {
    final Response response = await _client.put('/tokens/refresh', data: {
      'old_token': token,
    });

    return response.data['access_token'];
  }
}

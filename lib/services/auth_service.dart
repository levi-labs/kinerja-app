import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kinerja_app/models/login_form_model.dart';
import 'package:kinerja_app/models/user_form_model.dart';
import 'package:kinerja_app/shared/shared_value.dart';

class AuthService {
  Future<UserModel> login(LoginFormModel data) async {
    try {
      var url = Uri.parse('$baseUrl/login');
      var response = await http.post(
        url,
        body: data.toJson(),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(response.body));
        user = user.copyWith(password: data.password);
        await secureStorage(user);
        return user;
      } else {
        throw jsonDecode(response.body)['error'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final token = await getToken();
      var url = Uri.parse('$baseUrl/logout');
      var response = await http.post(
        url,
        headers: {'Accept': 'application/json', 'Authorization': token},
      );

      if (response.statusCode == 200) {
        await clearLocalStorage();
      } else {
        throw jsonDecode(response.body)['error'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> secureStorage(UserModel user) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'username', value: user.username);
      await storage.write(key: 'password', value: user.password);
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginFormModel> getCurrentCredentials() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> credentials = await storage.readAll();
      if (credentials['username'] == null || credentials['password'] == null) {
        throw 'Username or Password not found';
      } else {
        final LoginFormModel data = LoginFormModel(
          username: credentials['username']!,
          password: credentials['password']!,
        );
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      if (token == null) {
        throw 'Token not found';
      } else {
        return 'Bearer $token';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearLocalStorage() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }
}

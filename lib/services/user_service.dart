import 'dart:convert';

import 'package:kinerja_app/models/user_form_model.dart';
import 'package:http/http.dart' as http;
import 'package:kinerja_app/services/auth_service.dart';
import 'package:kinerja_app/shared/shared_value.dart';

class UserService {
  Future<List<UserModel>> getUser() async {
    try {
      var url = Uri.parse('$baseUrl/user');
      var token = await AuthService().getToken();
      var response = await http.get(
        url,
        headers: {
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        List<UserModel> data = (jsonDecode(response.body) as List)
            .map((e) => UserModel.fromJson(e))
            .toList();

        return data;
      }

      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createUser(UserModel data) async {
    try {
      var url = Uri.parse('$baseUrl/user');
      var token = await AuthService().getToken();
      var response = await http.post(
        url,
        body: jsonEncode(data.toJson()),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserPassword(UserModel data) async {
    try {
      var url = Uri.parse('$baseUrl/user/${data.id}');
      var token = await AuthService().getToken();
      var response = await http.put(
        url,
        body: jsonEncode(data.toJson()),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(int id) async {
    try {
      var url = Uri.parse('$baseUrl/user/$id');
      var token = await AuthService().getToken();
      var response = await http.get(
        url,
        headers: {
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        UserModel data = UserModel.fromJson(jsonDecode(response.body));
        return data;
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(UserModel data) async {
    try {
      var url = Uri.parse('$baseUrl/user/${data.id}');
      var token = await AuthService().getToken();
      var response = await http.put(
        url,
        body: jsonEncode(data.toJson()),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(UserModel data) async {
    try {
      var url = Uri.parse('$baseUrl/user/${data.id}');
      var token = await AuthService().getToken();
      var response = await http.delete(
        url,
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }
}

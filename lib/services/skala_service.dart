import 'dart:convert';

import 'package:kinerja_app/models/skala_from_model.dart';
import 'package:kinerja_app/services/auth_service.dart';
import 'package:kinerja_app/shared/shared_value.dart';
import 'package:http/http.dart' as http;

class SkalaService {
  Future<List<SkalaFormModel>> getSkala() async {
    try {
      final token = await AuthService().getToken();
      var url = Uri.parse('$baseUrl/skala');
      var response = await http.get(
        url,
        headers: {
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        List<SkalaFormModel> data = (jsonDecode(response.body) as List)
            .map((e) => SkalaFormModel.fromJson(e))
            .toList();
        return data;
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<SkalaFormModel> getSkalaById(int id) async {
    try {
      final token = await AuthService().getToken();
      var url = Uri.parse('$baseUrl/skala/$id');
      var response = await http.get(
        url,
        headers: {
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        return SkalaFormModel.fromJson(jsonDecode(response.body));
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createSkala(SkalaFormModel data) async {
    try {
      final token = await AuthService().getToken();
      var url = Uri.parse('$baseUrl/skala');
      var response = await http.post(
        url,
        body: jsonEncode(data),
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

  Future<void> updateSkala(SkalaFormModel data) async {
    try {
      final token = await AuthService().getToken();
      var id = data.id;
      var url = Uri.parse('$baseUrl/skala/$id');

      var response = await http.put(
        url,
        body: jsonEncode(data.toJson()),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['message'];
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSkala(int id) async {
    try {
      final token = await AuthService().getToken();
      var url = Uri.parse('$baseUrl/skala/$id');
      var response = await http.delete(
        url,
        headers: {
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['message'];
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }
}

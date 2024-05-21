import 'dart:convert';

import 'package:kinerja_app/models/kriteria_form_model.dart';
import 'package:kinerja_app/services/auth_service.dart';
import 'package:kinerja_app/shared/shared_value.dart';
import 'package:http/http.dart' as http;

class KriteriaService {
  Future<List<KriteriaFormModel>> getKriteria() async {
    try {
      final token = await AuthService().getToken();
      var url = Uri.parse('$baseUrl/kriteria');
      var response = await http.get(
        url,
        headers: {
          'Authorization': token,
        },
      );
      // print(response.body + 'kriteria');
      if (response.statusCode == 200) {
        List<KriteriaFormModel> data = (jsonDecode(response.body) as List)
            .map((e) => KriteriaFormModel.fromJson(e))
            .toList();
        return data;
      }

      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<KriteriaFormModel> getKriteriaById(int id) async {
    try {
      final token = await AuthService().getToken();
      var url = Uri.parse('$baseUrl/kriteria/$id');
      var response = await http.get(
        url,
        headers: {
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        // print(response.body + 'kriteria');
        return KriteriaFormModel.fromJson(jsonDecode(response.body));
      }

      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<KriteriaFormModel> createKriteria(KriteriaFormModel data) async {
    try {
      final token = await AuthService().getToken();
      var url = Uri.parse('$baseUrl/kriteria');
      var response = await http.post(
        url,
        body: jsonEncode(data.toJson()),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return KriteriaFormModel.fromJson(jsonDecode(response.body));
      }

      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<KriteriaFormModel> updateKriteria(KriteriaFormModel data) async {
    try {
      final token = await AuthService().getToken();
      var id = data.id;
      var url = Uri.parse('$baseUrl/kriteria/$id');

      var response = await http.put(
        url,
        body: jsonEncode(data.toJson()),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return KriteriaFormModel.fromJson(jsonDecode(response.body));
      }

      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteKriteria(int id) async {
    try {
      final token = await AuthService().getToken();
      var url = Uri.parse('$baseUrl/kriteria/$id');
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

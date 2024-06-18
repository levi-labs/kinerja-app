import 'dart:convert';

import 'package:kinerja_app/models/indikator_form_model.dart';
import 'package:kinerja_app/services/auth_service.dart';
import 'package:kinerja_app/shared/shared_value.dart';
import 'package:http/http.dart' as http;

class IndikatorService {
  Future<List<IndikatorFormModel>> getIndikator() async {
    try {
      final token = await AuthService().getToken();
      var url = Uri.parse('$baseUrl/indikator');
      var response = await http.get(
        url,
        headers: {
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        List<IndikatorFormModel> data = (jsonDecode(response.body) as List)
            .map((e) => IndikatorFormModel.fromJson(e))
            .toList();
        return data;
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<IndikatorFormModel>> getGrupIndikatorById(int id) async {
    try {
      final token = await AuthService().getToken();
      var url = Uri.parse('$baseUrl/indikator/kriteria/$id');
      var response = await http.get(
        url,
        headers: {
          'Authorization': token,
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        // print(response.body + 'indikator');
        List<IndikatorFormModel> data = (jsonDecode(response.body) as List)
            .map((e) => IndikatorFormModel.fromJson(e))
            .toList();

        return data;
      }

      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createIndikator(IndikatorFormModel data) async {
    try {
      final token = await AuthService().getToken();
      var url = Uri.parse('$baseUrl/indikator');
      var response = await http.post(
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

  Future<IndikatorFormModel> getIndikatorById(int id) async {
    try {
      final token = await AuthService().getToken();
      var url = Uri.parse('$baseUrl/indikator/$id');
      var response = await http.get(
        url,
        headers: {
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        return IndikatorFormModel.fromJson(jsonDecode(response.body));
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateIndikator(IndikatorFormModel data) async {
    try {
      final token = await AuthService().getToken();
      var id = data.id;
      var url = Uri.parse('$baseUrl/indikator/$id');
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

  Future<void> deleteIndikator(int id) async {
    try {
      final token = await AuthService().getToken();
      var url = Uri.parse('$baseUrl/indikator/$id');
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

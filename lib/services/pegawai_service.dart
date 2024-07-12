import 'dart:convert';

import 'package:kinerja_app/models/pegawai_form_model.dart';
import 'package:kinerja_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:kinerja_app/shared/shared_value.dart';

class PegawaiService {
  Future<List<PegawaiFormModel>> getPegawai() async {
    try {
      var url = Uri.parse('$baseUrl/pegawai');
      var token = await AuthService().getToken();
      var response = await http.get(
        url,
        headers: {'Authorization': token},
      );

      if (response.statusCode == 200) {
        List<PegawaiFormModel> data = (jsonDecode(response.body) as List)
            .map((e) => PegawaiFormModel.fromJson(e))
            .toList();
        return data;
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createPegawai(PegawaiFormModel data) async {
    try {
      var url = Uri.parse('$baseUrl/pegawai');
      var token = await AuthService().getToken();

      var response = await http.post(
        url,
        body: jsonEncode(data),
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

  Future<PegawaiFormModel> getPegawaiById(int id) async {
    try {
      var url = Uri.parse('$baseUrl/pegawai/$id');
      var token = await AuthService().getToken();
      var response = await http.get(
        url,
        headers: {'Authorization': token},
      );

      if (response.statusCode == 200) {
        return PegawaiFormModel.fromJson(jsonDecode(response.body));
      }

      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePegawai(PegawaiFormModel data) async {
    try {
      var id = data.id;
      var url = Uri.parse('$baseUrl/pegawai/$id');
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
        return jsonDecode(response.body)['message'];
      }

      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }
}

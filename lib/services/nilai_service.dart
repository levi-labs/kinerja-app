import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kinerja_app/models/nilai_form_model.dart';
import 'package:kinerja_app/services/auth_service.dart';
import 'package:kinerja_app/shared/shared_value.dart';

class NilaiService {
  Future<List<NilaiFormModel>> getNilai() async {
    try {
      var url = Uri.parse('$baseUrl/nilai');
      var token = await AuthService().getToken();
      var response = await http.get(
        url,
        headers: {'Authorization': token},
      );

      if (response.statusCode == 200) {
        List<NilaiFormModel> data = (jsonDecode(response.body) as List)
            .map((e) => NilaiFormModel.fromJson(e))
            .toList();
        return data;
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NilaiFormModel>> getNilaiByDate(String date) async {
    try {
      var url = Uri.parse('$baseUrl/nilai/$date');
      var token = await AuthService().getToken();
      var response = await http.get(
        url,
        headers: {'Authorization': token},
      );
      if (response.statusCode == 200) {
        List<NilaiFormModel> data = (jsonDecode(response.body) as List)
            .map((e) => NilaiFormModel.fromJson(e))
            .toList();
        return data;
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinerja_app/models/nilai_form_by_date_model.dart';
import 'package:kinerja_app/models/nilai_form_create_model.dart';

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

  Future<List<NilaiByDate>> getNilaiByDate(String date) async {
    try {
      var url = Uri.parse('$baseUrl/nilai/list/$date');
      var token = await AuthService().getToken();
      var response = await http.get(
        url,
        headers: {'Authorization': token},
      );
      if (response.statusCode == 200) {
        // List<NilaiFormModel> data = (jsonDecode(response.body) as List)
        //     .map((e) => NilaiFormModel.fromJson(e))
        //     .toList();

        List<NilaiByDate> data = (jsonDecode(response.body) as List)
            .map((e) => NilaiByDate.fromJson(e))
            .toList();

        return data;
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NilaiCreateFormModel>> createNilaiByDate(
      String tanggalNilai) async {
    try {
      print(tanggalNilai);
      var url = Uri.parse('$baseUrl/nilai/create/$tanggalNilai');
      var token = await AuthService().getToken();
      var response = await http.get(
        url,
        headers: {
          'Authorization': token,
        },
      );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        List<NilaiCreateFormModel> data = [
          NilaiCreateFormModel.fromJson(jsonData)
        ];

        // print(jsonDecode(response.body));
        return data;
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      // print(e);

      rethrow;
    }
  }

  Future<void> storeNilai(String idPegawai, List<int> controllerId,
      List<int> controllerNilai, String tanggalNilai) async {
    try {
      var url = Uri.parse('$baseUrl/nilai/post');
      var token = await AuthService().getToken();
      var response = await http.post(
        url,
        headers: {
          'Authorization': token,
        },
        body: {
          'pegawai_id': idPegawai,
          'indikator_id': jsonEncode(controllerId),
          'nilai_input': jsonEncode(controllerNilai),
          'tanggal_nilai': tanggalNilai
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'];
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }

  Future<NilaiCreateFormModel> getNilaiByPegawai(String idPegawai) async {
    try {
      var url = Uri.parse('$baseUrl/nilai/edit/$idPegawai');
      var token = await AuthService().getToken();
      var response = await http.get(
        url,
        headers: {
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        NilaiCreateFormModel data = NilaiCreateFormModel.fromJson(jsonData);
        return data;
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }
}

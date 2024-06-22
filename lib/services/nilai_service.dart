import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  Future<List<NilaiFormModel>> getNilaiByDate(String date) async {
    try {
      var url = Uri.parse('$baseUrl/nilai/$date');
      var token = await AuthService().getToken();
      var response = await http.get(
        url,
        headers: {'Authorization': token},
      );
      if (response.statusCode == 200) {
        // List<NilaiFormModel> data = (jsonDecode(response.body) as List)
        //     .map((e) => NilaiFormModel.fromJson(e))
        //     .toList();

        List<NilaiFormModel> data =
            (jsonDecode(response.body) as Map<String, dynamic>)['data']
                .map<NilaiFormModel>((e) => NilaiFormModel.fromJson(e))
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
        return data;
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      print(e);

      rethrow;
    }
  }

  Future<void> storeNilai(String idPegawai, List<int> controllerId,
      List<int> controllerNilai) async {
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
          'indikator_id': controllerId,
          'nilai_input': controllerNilai,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['message'];
      }
      throw jsonDecode(response.body)['error'];
    } catch (e) {
      rethrow;
    }
  }
}

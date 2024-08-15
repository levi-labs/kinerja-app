import 'dart:convert';

import 'package:kinerja_app/models/dashboard_form_model.dart';
import 'package:http/http.dart' as http;
import 'package:kinerja_app/services/auth_service.dart';
import 'package:kinerja_app/shared/shared_value.dart';

class DashboardService {
  Future<DashboardFormModel> getDashboard() async {
    try {
      final token = await AuthService().getToken();
      var url = Uri.parse('$baseUrl/dashboard');
      var response = await http.get(
        url,
        headers: {
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        return DashboardFormModel.fromJson(jsonDecode(response.body));
      } else {
        throw jsonDecode(response.body)['error'];
      }
    } catch (e) {
      rethrow;
    }
  }
}

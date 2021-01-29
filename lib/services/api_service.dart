import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qr_code/services/api.dart';

class ApiService {
  Future getUser({id}) async {
    try {
      var response = await http.get('${API.getProfile}/$id');
      if (response.statusCode == 200) {
        var data = response.body;
        return jsonDecode(data);
      }
      return null;
    } catch (e) {
      throw e;
    }
  }
}

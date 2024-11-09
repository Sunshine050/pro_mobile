import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl = '172.22.160.1:3000';

  String getServerUrl() {
    return _baseUrl;
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<dynamic> getReq(String endpoint, bool useToken) async {
    final String? token;
    final Map<String, String> headers = {};

    if (useToken) {
      token = (await getToken())!;
      headers['Authorization'] = 'Bearer $token';
    }

    final http.Response response =
        await http.get(Uri.http(_baseUrl, endpoint), headers: headers);

    return response;
  }

  Future<dynamic> postReq(
      String endpoint, Map<String, dynamic> body, bool useToken) async {
    final String? token;
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    if (useToken) {
      token = (await getToken())!;
      headers['Authorization'] = 'Bearer $token';
    }

    final http.Response response = await http.post(Uri.http(_baseUrl, endpoint),
        headers: headers, body: jsonEncode(body));

    return response;
  }

  Future<dynamic> putReq(
      String endpoint, Map<String, dynamic> body, bool useToken) async {
    final String? token;
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    if (useToken) {
      token = (await getToken())!;
      headers['Authorization'] = 'Bearer $token';
    }

    final http.Response response = await http.put(Uri.http(_baseUrl, endpoint),
        headers: headers, body: jsonEncode(body));

    return response;
  }

  Future<dynamic> deleteReq(
      String endpoint, Map<String, dynamic> body, bool useToken) async {
    final String? token;
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    if (useToken) {
      token = (await getToken())!;
      headers['Authorization'] = 'Bearer $token';
    }

    final http.Response response = await http.delete(
        Uri.http(_baseUrl, endpoint),
        headers: headers,
        body: jsonEncode(body));

    return response;
  }
}

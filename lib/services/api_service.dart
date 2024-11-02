import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.1.7:4000';

  Future<dynamic> getRequest(String endpoint,
      {Map<String, String>? headers}) async {
    final response =
        await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
    return _processResponse(response);
  }

  Future<dynamic> postRequest(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    final response = await http.post(Uri.parse('$baseUrl$endpoint'),
        headers: headers, body: jsonEncode(data));
    return _processResponse(response);
  }

  Future<dynamic> putRequest(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    final response = await http.put(Uri.parse('$baseUrl$endpoint'),
        headers: headers, body: jsonEncode(data));
    return _processResponse(response);
  }

  Future<dynamic> deleteRequest(String endpoint,
      {Map<String, String>? headers}) async {
    final response =
        await http.delete(Uri.parse('$baseUrl$endpoint'), headers: headers);
    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}

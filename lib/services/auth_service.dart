import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrl = 'http:/register/api/auth'; // เปลี่ยนเป็น URL ของ API ที่ใช้

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // รายละเอียดของข้อผิดพลาดที่เกิดขึ้น
      var errorMessage = json.decode(response.body)['message'] ?? 'Failed to login';
      throw Exception(errorMessage);
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      // รายละเอียดของข้อผิดพลาดที่เกิดขึ้น
      var errorMessage = json.decode(response.body)['message'] ?? 'Failed to register';
      throw Exception(errorMessage);
    }
  }
}

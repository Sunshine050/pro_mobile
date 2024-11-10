import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl = '192.168.167.205:3000';

  String getServerUrl() {
    return _baseUrl;
  }

  // ดึง token จาก SharedPreferences
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  // ฟังก์ชัน GET request ที่ใช้ token
  Future<dynamic> getReq(String endpoint, bool useToken) async {
    final String? token;
    final Map<String, String> headers = {};

    if (useToken) {
      token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      headers['Authorization'] = 'Bearer $token'; // ใช้ token ใน header
    }

    final http.Response response =
        await http.get(Uri.http(_baseUrl, endpoint), headers: headers);

    return response;
  }

  // ฟังก์ชัน POST request ที่ใช้ token
  Future<dynamic> postReq(
      String endpoint, Map<String, dynamic> body, bool useToken) async {
    final String? token;
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    if (useToken) {
      token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      headers['Authorization'] = 'Bearer $token'; // ใช้ token ใน header
    }

    final http.Response response = await http.post(Uri.http(_baseUrl, endpoint),
        headers: headers, body: jsonEncode(body));

    return response;
  }

  // ฟังก์ชัน PUT request ที่ใช้ token
  Future<dynamic> putReq(
      String endpoint, Map<String, dynamic> body, bool useToken) async {
    final String? token;
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    if (useToken) {
      token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      headers['Authorization'] = 'Bearer $token'; // ใช้ token ใน header
    }

    final http.Response response = await http.put(Uri.http(_baseUrl, endpoint),
        headers: headers, body: jsonEncode(body));

    return response;
  }

  // ฟังก์ชัน DELETE request ที่ใช้ token
  Future<dynamic> deleteReq(
      String endpoint, Map<String, dynamic> body, bool useToken) async {
    final String? token;
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    if (useToken) {
      token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      headers['Authorization'] = 'Bearer $token'; // ใช้ token ใน header
    }

    final http.Response response = await http.delete(
        Uri.http(_baseUrl, endpoint),
        headers: headers,
        body: jsonEncode(body));

    return response;
  }

  // ฟังก์ชัน bookRoom สำหรับการจองห้อง
  Future<void> bookRoom(int roomId, String token) async {
    final Map<String, dynamic> body = {
      'roomId': roomId,
      'token': token,
    };

    final response = await postReq('/api/bookRoom', body, true);

    if (response.statusCode == 200) {
      print('Room booked successfully');
    } else {
      print('Failed to book room. Response: ${response.body}');
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pro_mobile/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ApiService {
  // ฟังก์ชัน validateEmail สำหรับตรวจสอบและเติมโดเมนให้กับอีเมล
  String validateEmail(String email) {
    if (!email.contains('@')) {
      email += '@lamduan.mfu.ac.th';
    }
    return email;
  }

  // ฟังก์ชัน register สำหรับการลงทะเบียน
  Future<http.Response> register(
      String username, String email, String password) async {
    final validatedEmail = validateEmail(email);
    final response = await ApiService().postReq(
        "/api/auth/register",
        {'username': username, 'email': validatedEmail, 'password': password},
        false);

    return response;
  }

  // ฟังก์ชัน login สำหรับการเข้าสู่ระบบ
  Future<http.Response> login(String username, String password) async {
    final response = await ApiService().postReq(
        "/api/auth/login", {'username': username, 'password': password}, false);

    if (response.statusCode == 200) {
      // เก็บ token ที่ได้รับหลังจาก login สำเร็จ
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = jsonDecode(response.body)['token']; // ถ้า API คืนค่า token
      await prefs.setString('token', token); // เก็บ token ใน SharedPreferences

      // แสดง token ในคอนโซล
      print("Login successful. Token: $token"); // พิมพ์ token ในคอนโซล
    } else {
      print("Login failed. Status code: ${response.statusCode}");
    }

    return response;
  }
}

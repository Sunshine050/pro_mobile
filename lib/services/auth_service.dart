import 'package:http/http.dart' as http;
import 'package:pro_mobile/services/api_service.dart';

class AuthService extends ApiService {
  // ฟังก์ชัน validateEmail สำหรับตรวจสอบและเติมโดเมนให้กับอีเมล
  String validateEmail(String email) {
    // ถ้าไม่มี '@' ในอีเมล ก็จะเพิ่ม '@lamduan.mfu.ac.th'
    if (!email.contains('@')) {
      email += '@lamduan.mfu.ac.th';
    }
    return email;
  }

  // ฟังก์ชัน register สำหรับการลงทะเบียน
  Future<http.Response> register(
      String username, String email, String password) async {
    // ตรวจสอบและเติมโดเมนให้อีเมล
    final validatedEmail = validateEmail(email);

    // ส่งคำขอ POST ไปที่ API สำหรับการลงทะเบียน
    final response = await ApiService().postReq(
        "/api/auth/register",
        {
          'username': username,
          'email': validatedEmail,  // ส่งอีเมลที่ตรวจสอบแล้ว
          'password': password      // ส่งรหัสผ่านที่ถูกต้อง
        },
        false);

    return response;
  }

  // ฟังก์ชัน login สำหรับการเข้าสู่ระบบ
  Future<http.Response> login(String username, String password) async {
    // ส่งคำขอ POST ไปที่ API สำหรับการเข้าสู่ระบบ
    final response = await ApiService().postReq(
        "/api/auth/login", 
        {
          'username': username,   // ส่งชื่อผู้ใช้
          'password': password    // ส่งรหัสผ่าน
        },
        false);

    return response;
  }
}

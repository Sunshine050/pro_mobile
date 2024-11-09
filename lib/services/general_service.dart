import 'package:http/http.dart' as http;
import 'package:pro_mobile/services/api_service.dart';

class GeneralService extends ApiService {
  // get userData for profile
  Future<http.Response> getUserData() async {
    final response = await ApiService().getReq("/user/userData", true);
    return response;
  }

  // get history
  Future<http.Response> getUserHistory() async {
    final response = await ApiService().getReq("/user/history", true);
    return response;
  }

  // get summary slot status for dashboard
  Future<http.Response> getSummary() async {
    final response = await ApiService().getReq("/user/dashboard", true);
    return response;
  }
}

import 'package:http/http.dart' as http;
import 'package:pro_mobile/services/api_service.dart';

class StudentService extends ApiService {
  // book a room
  Future<http.Response> bookRoom(Map<String, dynamic> bookingData) async {
    final response =
        await ApiService().postReq("/student/book", bookingData, true);
    return response;
  }

  // cancel req
  Future<http.Response> cancel(Map<String, dynamic> bookingID) async {
    final response =
        await ApiService().putReq("/student/cancel", bookingID, true);
    return response;
  }

  // get pending req
  Future<http.Response> booking() async {
    final response = await ApiService().getReq("/student/book", true);
    return response;
  }

  // bookmarked a room
  Future<http.Response> bookmarked(Map<String, dynamic> roomID) async {
    final response =
        await ApiService().postReq("/student/bookmarked", roomID, true);
    return response;
  }

  // delete bookmarked room
  Future<http.Response> unbookmarked(Map<String, dynamic> roomID) async {
    final response =
        await ApiService().deleteReq("/student/unBookmarked", roomID, true);
    return response;
  }

  // get all bookmarked rooms
  Future<http.Response> getBookmarks() async {
    final response = await ApiService().getReq("/student/getBookmarked", true);
    return response;
  }
}

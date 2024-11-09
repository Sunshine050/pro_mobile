import 'package:http/http.dart' as http;
import 'package:pro_mobile/services/api_service.dart';

class RoomsService extends ApiService {
  // get all rooms
  Future<http.Response> getRooms() async {
    final response = await ApiService().getReq("/room/all", true);
    return response;
  }

  // get a room
  Future<http.Response> getRoom(String roomId) async {
    final response = await ApiService().getReq("/room/$roomId", true);
    return response;
  }

  // search by room name
  Future<http.Response> searchRoom(String roomName) async {
    final response = await ApiService().getReq("/room/search/$roomName", true);
    return response;
  }

  // filter by available slots
  Future<http.Response> filterRoom(Map<String, dynamic> filterOptions) async {
    print(filterOptions);
    final response =
        await ApiService().postReq('/room/filter', filterOptions, true);
    return response;
  }
}

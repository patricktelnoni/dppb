import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class ContentService{
  Future<http.Response> getContentByUserId(int userId) async {

    final url  = "https://palugada.me/api/users/$userId/posts";
    final token = await storage.read(key: 'access_token');

    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Accept': 'application/json;',
        'Authorization': 'Bearer $token', // Include the token in the header
      },
    );
    print(response.body);

    return response;
  }

  Future<http.Response> getContentList() async {
    final url  = "https://palugada.me/api/posts";
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Accept': 'application/json;',
        //'Authorization': 'Bearer $token', // Include the token in the header
      },
    );
    print(response.body);

    return response;
  }
}

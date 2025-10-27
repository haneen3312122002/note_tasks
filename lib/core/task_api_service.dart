import 'dart:convert';
import 'package:http/http.dart' as http;

class TaskApiService {
  final String baseUrl = 'https://dummyjson.com';

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('GET request failed: $endpoint');
    }
  }
}

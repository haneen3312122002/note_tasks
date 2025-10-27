import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApiService {
  final String apiUrl = 'https://dummyjson.com';

  Future<Map<String, dynamic>> _get(String endpoint) async {
    final response = await http.get(Uri.parse('$apiUrl/$endpoint'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('GET request failed: $endpoint');
    }
  }

  //all users with basic data:
  Future<List<Map<String, dynamic>>> getBasicUsers() async {
    final data = await _get('users');
    final List users = data['users'] ?? [];
    return users.map((u) {
      return {
        'id': u['id'],
        'role': u['role'],
        'firstName': u['firstName'],
        'lastName': u['lastName'],
        'email': u['email'],
        'image': u['image'],
        'age': u['age'],
        'gender': u['gender'],
      };
    }).toList();
  }

  //get all dtata for user by id:
  Future<Map<String, dynamic>> getUserFull(int id) async {
    final data = await _get('users/$id');
    return data;
  }

  //get user bank data by id:
  Future<Map<String, dynamic>> getUserBank(int id) async {
    final data = await _get('users/$id');
    return data['bank'] ?? {};
  }

  //get user comapany dtta by id:
  Future<Map<String, dynamic>> getUserCompany(int id) async {
    final data = await _get('users/$id');
    return data['company'] ?? {};
  }

  Future<Map<String, dynamic>> getUserCrypto(int id) async {
    final data = await _get('users/$id');
    return data['crypto'] ?? {};
  }

  Future<Map<String, dynamic>> getUserAddress(int id) async {
    final data = await _get('users/$id');
    return data['address'] ?? {};
  }
}

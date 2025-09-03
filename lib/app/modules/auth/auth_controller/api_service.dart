import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://172.252.13.83:8000/api/v1';

  Future<Map<String, dynamic>> login({
    required String email,
    required String fullname,
    required bool isGoogleLogin,
    bool isAppleLogin = false,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': '',
          'isGoogleLogin': isGoogleLogin,
          'fullname': fullname,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to login: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('Login error: $error');
    }
  }
}
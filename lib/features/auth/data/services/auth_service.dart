import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yardex_user/features/auth/data/models/user_model.dart';

class AuthService {
  final String baseUrl;

  AuthService({required this.baseUrl});

  Future<void> register(UserModel user, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user': user.username,
        'email': user.email,
        'password': password,
        'phone_number': user.phoneNumber,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register user: ${response.body}');
    }
  }
}

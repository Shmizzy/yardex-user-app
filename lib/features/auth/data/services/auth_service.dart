import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yardex_user/core/errors/exceptions.dart';
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

    if (response.statusCode == 400) {
      throw ValidationException('Invalid input');
    } else if (response.statusCode == 401) {
      throw AuthException('User already exists');
    } else if (response.statusCode == 500) {
      throw ServerException('Server error');
    } else if (response.statusCode != 200) {
      throw NetworkException('Failed to register user: ${response.body}');
    }
  }

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 400) {
      throw ValidationException('Invalid input');
    } else if (response.statusCode == 401) {
      throw AuthException('Invalid credentials');
    } else if (response.statusCode == 500) {
      throw ServerException('Server error');
    } else if (response.statusCode != 200) {
      throw NetworkException('Failed to login: ${response.body}');
    }
  }
}

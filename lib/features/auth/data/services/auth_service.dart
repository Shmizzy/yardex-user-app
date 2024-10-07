import 'dart:convert';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:yardex_user/core/errors/exceptions.dart' as yardex_exceptions;
import 'package:yardex_user/features/auth/data/models/user_model.dart';

class AuthService {
  final String baseUrl;

  AuthService({required this.baseUrl});

  Future<void> register(UserModel user, String password) async {
    /* final response = await http.post(
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
      throw AuthException('Unauthroized');
    } else if (response.statusCode == 500) {
      throw ServerException('Server error');
    } else if (response.statusCode != 200) {
      throw NetworkException('Failed to register user: ${response.body}');
    } */

    try {
      final result = await Amplify.Auth.signUp(
          username: user.username,
          password: password,
          options: SignUpOptions(userAttributes: {
            AuthUserAttributeKey.email: user.email,
            AuthUserAttributeKey.phoneNumber: user.phoneNumber,
          }));
      print(result);
    } catch (e) {
      throw yardex_exceptions.NetworkException('Failed to register user: $e');
    }
  }

  Future<void> confirmUser(String username, String confirmationCode) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
      print(result);
    } catch (e) {
      throw yardex_exceptions.NetworkException('Failed to confirm user: $e');
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
      throw yardex_exceptions.ValidationException('Invalid input');
    } else if (response.statusCode == 401) {
      throw yardex_exceptions.AuthException('Invalid credentials');
    } else if (response.statusCode == 500) {
      throw yardex_exceptions.ServerException('Server error');
    } else if (response.statusCode != 200) {
      throw yardex_exceptions.NetworkException(
          'Failed to login: ${response.body}');
    }
  }
}

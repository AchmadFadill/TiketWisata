import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tiket_wisata/data/datasources/auth_local_datasources.dart';
import '../models/user_model.dart';

class CustomException implements Exception {
  final String message;
  CustomException(this.message);

  @override
  String toString() => message;
}

class AuthRemoteDataSource {
  final String baseUrl = 'https://tiket.febryann.my.id/api';
  final AuthLocalDataSource _local = AuthLocalDataSource();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final Map<String, dynamic> data = json.decode(response.body);
      print('[LOGIN RESPONSE] ${response.statusCode} - $data');

      if (response.statusCode == 200 && data['token'] != null) {
        // ✅ Simpan token ke SharedPreferences
        await _local.saveToken(data['token']);

        return {
          'token': data['token'],
          'user': UserModel.fromJson(data['user']),
        };
      } else {
        String errorMessage = data['message'] ?? 'Login failed';
        if (data.containsKey('errors')) {
          final errors = data['errors'] as Map<String, dynamic>;
          if (errors.isNotEmpty) {
            final firstErrorList = errors.values.first;
            if (firstErrorList is List && firstErrorList.isNotEmpty) {
              errorMessage = firstErrorList.first.toString();
            }
          }
        }
        throw CustomException(errorMessage);
      }
    } catch (e) {
      throw CustomException(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> logout() async {
    final token = await _local.getToken();
    if (token == null) throw CustomException('Token tidak ditemukan');

    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print('[LOGOUT RESPONSE] ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) {
      await _local.clearToken();
    } else {
      throw CustomException('Logout gagal');
    }
  }
}

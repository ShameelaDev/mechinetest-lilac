import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'https://test.gslstudent.lilacinfotech.com';
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/api/lead/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userField': email, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print('Parsed response data: $responseData');

      if (responseData['status'] == true) {
        final auth = responseData['data']['auth'];

        await _storage.write(key: 'accessToken', value: auth['access_token']);
        await _storage.write(key: 'refreshToken', value: auth['refresh_token']);

        return true;
      } else {
        print('Error message from server: ${responseData['message']}');
      }
    } else {
      print('Server returned HTTP error: ${response.statusCode}');
    }
    return false;
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  Future<void> refreshAccessToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');

    if (refreshToken != null) {
      final url = Uri.parse('$_baseUrl/refresh-token');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'refresh_token': refreshToken}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == true) {
          final newAccessToken = responseData['data']['auth']['access_token'];

          await _storage.write(key: 'accessToken', value: newAccessToken);
        }
      }
    }
  }
}

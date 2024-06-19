import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  Future<void> login({required String mixed, required String password}) async {
    try {
      final url = Uri.parse('https://api.socialverseapp.com/user/login');
      final response =
          await http.post(url, body: {'mixed': mixed, 'password': password});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _token = data['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        print("$token");

        notifyListeners();
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed: $e');
    }
  }
}

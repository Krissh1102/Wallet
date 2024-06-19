import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class WalletProvider with ChangeNotifier {
  double _balance = 0;

  double get balance => _balance;

  Future<void> retrieveBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url =
        Uri.parse('https://api.socialverseapp.com/solana/wallet/balance');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _balance = data['balance'];
      notifyListeners();
    } else {
      throw Exception('Failed to retrieve balance');
    }
  }

  createWallet(String walletName) {}
}

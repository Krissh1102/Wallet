import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WalletProvider with ChangeNotifier {
  Future<void> createWallet(String walletName) async {
    final url = Uri.parse(
        'https://api.socialverseapp.com/solana/wallet/create'); // Replace with your API endpoint
    final String userPin = _generateRandomPin();

    final response = await http.post(
      url,
      body: jsonEncode({
        'wallet_name': walletName,
        'network': 'devnet',
        'user_pin': userPin,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Successfully created wallet
      final data = jsonDecode(response.body);
      print("Wallet Created: $data");
    } else {
      throw Exception('Failed to create wallet');
    }
  }

  String _generateRandomPin() {
    var rng = Random();
    return (rng.nextInt(900000) + 100000).toString();
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SwapProvider with ChangeNotifier {
  Future<void> swap(String walletAddress, String network, double amount) async {
    final url = Uri.parse(
        'https://api.socialverseapp.com/solana/wallet/swap'); // Replace with your API endpoint

    final response = await http.post(
      url,
      body: jsonEncode({
        'wallet_address': walletAddress,
        'network': network,
        'amount': amount,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Swap Successful: $data");
    } else {
      throw Exception('Failed to swap');
    }
  }
}

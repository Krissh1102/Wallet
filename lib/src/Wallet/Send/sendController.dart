import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendProvider with ChangeNotifier {
  Future<void> sendTransaction(String address, double amount) async {
    final url = Uri.parse(
        'https://api.socialverseapp.com/solana/wallet/transfer'); // Replace with your API endpoint

    final response = await http.post(
      url,
      body: jsonEncode({
        'wallet_address': address,
        'network': 'devnet',
        'amount': amount,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Successfully sent transaction
      final data = jsonDecode(response.body);
      print("Transaction Sent: $data");
      // Handle the response as needed
    } else {
      // Handle the error
      throw Exception('Failed to send transaction');
    }
  }
}

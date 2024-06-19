import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:wallet/src/Wallet/Send/sendController.dart';

class SendUsernameScreen extends StatefulWidget {
  @override
  _SendUsernameScreenState createState() => _SendUsernameScreenState();
}

class _SendUsernameScreenState extends State<SendUsernameScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String responseMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String username = usernameController.text.trim();
                String amount = amountController.text.trim();
                if (username.isEmpty || amount.isEmpty) {
                  setState(() {
                    responseMessage = 'Please enter all fields';
                  });
                  return;
                }
                try {
                  await Provider.of<SendProvider>(context, listen: false)
                      .sendTransaction(username, double.parse(amount));
                  setState(() {
                    responseMessage = 'Transaction sent successfully';
                  });
                } catch (e) {
                  setState(() {
                    responseMessage = 'Failed to send transaction: $e';
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Send'),
            ),
            SizedBox(height: 20),
            Text(responseMessage),
          ],
        ),
      ),
    );
  }
}

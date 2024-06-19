import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:wallet/src/Wallet/Send/sendController.dart';

class SendAddressScreen extends StatefulWidget {
  const SendAddressScreen({super.key});
  @override
  _SendAddressScreenState createState() => _SendAddressScreenState();
}

class _SendAddressScreenState extends State<SendAddressScreen> {
  final TextEditingController addressController = TextEditingController();
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
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Recipient Address',
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
                String address = addressController.text.trim();
                String amount = amountController.text.trim();
                if (address.isEmpty || amount.isEmpty) {
                  setState(() {
                    responseMessage = 'Please enter all fields';
                  });
                  return;
                }
                try {
                  await Provider.of<SendProvider>(context, listen: false)
                      .sendTransaction(address, double.parse(amount));
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

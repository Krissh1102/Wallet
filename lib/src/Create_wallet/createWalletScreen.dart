import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/src/Wallet/wallet_provider.dart';

class CreateWalletScreen extends StatefulWidget {
  const CreateWalletScreen({super.key});
  @override
  _CreateWalletScreenState createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  final TextEditingController walletNameController = TextEditingController();
  String responseMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: walletNameController,
              decoration: InputDecoration(
                labelText: 'Wallet Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  String walletName = walletNameController.text.trim();
                  if (walletName.isEmpty) {
                    setState(() {
                      responseMessage = 'Please enter a wallet name';
                    });
                    return;
                  }
                  try {
                    await Provider.of<WalletProvider>(context, listen: false)
                        .createWallet(walletName);
                    setState(() {
                      responseMessage = 'Wallet created successfully';
                      Navigator.pushReplacementNamed(context, '/wallet');
                    });
                  } catch (e) {
                    setState(() {
                      responseMessage = 'Failed to create wallet: $e';
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Create Wallet',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(responseMessage),
          ],
        ),
      ),
    );
  }
}

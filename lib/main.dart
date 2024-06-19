import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/src/Auth/auth_provider.dart';
import 'package:wallet/src/Auth/login.dart';
import 'package:wallet/src/Create_wallet/createWalletScreen.dart';
import 'package:wallet/src/Wallet/Send/Address.dart';
import 'package:wallet/src/Wallet/Send/Username.dart';
import 'package:wallet/src/Wallet/Swap/swapScreen.dart';
import 'package:wallet/src/Wallet/wallet.dart';
import 'package:wallet/src/Wallet/wallet_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wallet App',
        theme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return authProvider.token == null
                      ? LoginScreen()
                      : CreateWalletScreen();
                },
              ),
          '/wallet': (context) => WalletScreen(),
          '/create-wallet': (context) => CreateWalletScreen(),
          '/send-address': (context) => SendAddressScreen(),
          '/send-username': (context) => SendUsernameScreen(),
          '/swap': (_) => SwapScreen(),
        },
      ),
    );
  }
}

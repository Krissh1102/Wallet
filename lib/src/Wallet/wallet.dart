import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wallet/src/Wallet/Send/Address.dart';
import 'package:wallet/src/Wallet/Send/Username.dart';
import 'package:wallet/src/Wallet/Swap/swapScreen.dart';
import 'package:wallet/src/Wallet/wallet_provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

String selectedNetwork = 'Polygon Mainnet';
String selectedTab = 'Tokens';

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: Consumer<WalletProvider>(
        builder: (context, walletProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 124,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Balance',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '\$ ${walletProvider.balance}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'fjsfdafa0x',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            _showSendOptions(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: const Text('Send',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SwapScreen()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: const Text(
                              'Swap',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = 'Tokens';
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Tokens',
                              style: TextStyle(
                                color: selectedTab == 'Tokens'
                                    ? Colors.white
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (selectedTab == 'Tokens')
                              Container(
                                height: 2,
                                color: Colors.white,
                                margin: const EdgeInsets.only(top: 5),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = 'Activity';
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Activity',
                              style: TextStyle(
                                color: selectedTab == 'Activity'
                                    ? Colors.white
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (selectedTab == 'Activity')
                              Container(
                                height: 2,
                                color: Colors.white,
                                margin: const EdgeInsets.only(top: 5),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Add content based on selected tab here
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        TextButton(
          onPressed: () => _showNetworkSelector(context),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.purple,
                radius: 10,
              ),
              SizedBox(width: 5),
              Text(
                selectedNetwork,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            // Handle menu selection
            if (value == 'Account Details') {
              // Navigate to account details
            } else if (value == 'View on Explorer') {
              // Navigate to explorer
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'Account Details',
                child: Row(
                  children: [
                    Icon(Icons.account_circle, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Account Details'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'View on Explorer',
                child: Row(
                  children: [
                    Icon(Icons.explore, color: Colors.black),
                    SizedBox(width: 8),
                    Text('View on Explorer'),
                  ],
                ),
              ),
            ];
          },
          icon: Icon(Icons.more_vert, color: Colors.white),
        ),
      ],
      title: const Text(
        'Wallet',
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  void _showSendOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Send',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Row(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.wallet),
                      backgroundColor: Colors.grey[800],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Address', style: TextStyle(color: Colors.white)),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SendAddressScreen()),
                  );
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.person_2_outlined),
                      backgroundColor: Colors.grey[800],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Username', style: TextStyle(color: Colors.white)),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SendUsernameScreen()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showNetworkSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select a Network',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text(
                      'Polygon Mainnet',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: selectedNetwork == 'Polygon Mainnet'
                        ? Icon(Icons.check, color: Colors.yellow)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedNetwork = 'Polygon Mainnet';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Ethereum Mainnet',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: selectedNetwork == 'Ethereum Mainnet'
                        ? Icon(Icons.check, color: Colors.yellow)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedNetwork = 'Ethereum Mainnet';
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

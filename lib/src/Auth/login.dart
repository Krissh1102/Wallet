import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/src/Auth/auth_provider.dart';
import 'package:wallet/src/Create_wallet/createWalletScreen.dart';
import 'package:wallet/src/Wallet/wallet.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? mixedController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.close))),
            const Center(
                child: SizedBox(
              child: Text(
                "V",
                style: TextStyle(fontSize: 150, fontWeight: FontWeight.bold),
              ),
            )),
            TextField(
              controller: mixedController,
              decoration: InputDecoration(
                labelText: 'Username or Email',
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navigate to Forgot Password screen
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (mixedController!.text.trim().isEmpty ||
                    passwordController!.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter both fields')),
                  );
                  return;
                }
                try {
                  await Provider.of<AuthProvider>(context, listen: false).login(
                      mixed: mixedController!.text.trim(),
                      password: passwordController!.text.trim());
                  Navigator.pushReplacementNamed(context, '/create');
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to login')),
                  );
                  print("$error");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateWalletScreen()));
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: Divider(color: Colors.white)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('OR', style: TextStyle(color: Colors.white)),
                ),
                Expanded(child: Divider(color: Colors.white)),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Implement Google Sign-In
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              icon: Icon(
                Icons.login,
                color: Colors.white,
              ),
              label: Text(
                'Sign in with Google',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

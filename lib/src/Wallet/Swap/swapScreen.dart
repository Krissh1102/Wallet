import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/src/Wallet/Swap/swapController.dart';

class SwapScreen extends StatefulWidget {
  const SwapScreen({super.key});
  @override
  _SwapScreenState createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  final TextEditingController amountControllerPay = TextEditingController();
  final TextEditingController amountControllerReceive = TextEditingController();
  String fromNetwork = 'Vible';
  String toNetwork = 'Polygon';
  String responseMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Swap'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('you Pay',
                style: TextStyle(color: Colors.white, fontSize: 12)),
            const SizedBox(
              height: 10,
            ),
            _buildAmountAndNetworkSelector(
              context,
              'You Pay',
              amountControllerPay,
              fromNetwork,
              ['Vible', 'Polygon'],
              (value) {
                setState(() {
                  fromNetwork = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('you Pay',
                style: TextStyle(color: Colors.white, fontSize: 12)),
            SizedBox(height: 10),
            _buildAmountAndNetworkSelector(
              context,
              'To You Receive',
              amountControllerReceive,
              toNetwork,
              ['Polygon', 'Tether', 'USDC', 'Uniswap'],
              (value) {
                setState(() {
                  toNetwork = value;
                });
              },
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: _swap,
                child: Text('Swap'),
              ),
            ),
            SizedBox(height: 20),
            Text(responseMessage),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountAndNetworkSelector(
    BuildContext context,
    String label,
    TextEditingController controller,
    String currentValue,
    List<String> options,
    Function(String) onSelected,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildAmountInput(context, controller),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _buildNetworkSelector(
            context,
            currentValue,
            options,
            onSelected,
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInput(
    BuildContext context,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Amount',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildNetworkSelector(
    BuildContext context,
    String currentValue,
    List<String> options,
    Function(String) onSelected,
  ) {
    return OutlinedButton(
      onPressed: () => _showNetworkDialog(context, options, onSelected),
      style: OutlinedButton.styleFrom(
        side: BorderSide.none,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(currentValue),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  void _showNetworkDialog(
    BuildContext context,
    List<String> options,
    Function(String) onSelected,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Network'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options
                .map(
                  (option) => ListTile(
                    title: Text(option),
                    onTap: () {
                      onSelected(option);
                      Navigator.pop(context);
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  void _swap() async {
    String amount = amountControllerPay.text.trim();
    if (amount.isEmpty) {
      setState(() {
        responseMessage = 'Please enter an amount';
      });
      return;
    }

    try {
      String walletAddress = 'AxLXd6SsHBHB4HWhRMACuGsuvbtfEq1MsXQqhPaF6wkS';
      String network = fromNetwork == 'Vible' ? 'devnet' : 'mainnet';
      await Provider.of<SwapProvider>(context, listen: false)
          .swap(walletAddress, network, double.parse(amount));
      setState(() {
        responseMessage = 'Swap successful';
      });
    } catch (e) {
      setState(() {
        responseMessage = 'Failed to swap: $e';
      });
    }
  }
}

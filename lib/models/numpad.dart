import 'package:flutter/material.dart';

class Numpad extends StatelessWidget {
  final TextEditingController controller;
  final Function onConfirm;

  Numpad({required this.controller, required this.onConfirm});

  void _onKeyTap(String key) {
    if (key == 'C') {
      controller.clear();
    } else if (key == '<') {
      if (controller.text.isNotEmpty) {
        controller.text =
            controller.text.substring(0, controller.text.length - 1);
      }
    } else {
      controller.text += key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              _buildKey('1'),
              _buildKey('2'),
              _buildKey('3'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildKey('4'),
              _buildKey('5'),
              _buildKey('6'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildKey('7'),
              _buildKey('8'),
              _buildKey('9'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildKey('C'),
              _buildKey('0'),
              _buildKey('<'),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () => onConfirm(),
          child: Text('Send'),
        ),
      ],
    );
  }

  Widget _buildKey(String key) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onKeyTap(key),
        child: Container(
          margin: EdgeInsets.all(2),
          color: Colors.grey[300],
          child: Center(
            child: Text(
              key,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

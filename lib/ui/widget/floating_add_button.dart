import 'package:flutter/material.dart';

class FloatingAddButton extends StatelessWidget {
  final VoidCallback onPress;
  const FloatingAddButton({required this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      right: 20,
      child: FloatingActionButton(
        onPressed: onPress,
        child: const Icon(Icons.add),
      ),
    );
  }
}

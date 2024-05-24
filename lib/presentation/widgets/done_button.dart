//create DoneButton widget
import 'package:flutter/material.dart';

class DoneButton extends StatelessWidget {
  final void Function()? onPressed;
  const DoneButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 8, bottom: 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: onPressed,
          child: const Text('Done'),
        ),
      ),
    );
  }
}

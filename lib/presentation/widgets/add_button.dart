import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final int color;
  final void Function() onTap;
  const AddButton({super.key, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 55,
        decoration: _decoration(),
        child: const Icon(Icons.add),
      ),
    );
  }

  BoxDecoration _decoration() => BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.circular(10),
      );
}

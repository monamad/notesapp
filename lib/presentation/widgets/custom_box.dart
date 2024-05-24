import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function() ontap;
  const CustomBox(
      {super.key,
      required this.isSelected,
      required this.ontap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 8),
      child: InkWell(
        onTap: ontap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(
              color: (isSelected) ? Colors.black : Colors.white,
            ),
            color: (isSelected) ? Colors.white : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text.characters.first.toUpperCase() + text.substring(1),
            style: TextStyle(
                fontSize: 16, color: (isSelected) ? Colors.black : null),
          ),
        ),
      ),
    );
  }
}

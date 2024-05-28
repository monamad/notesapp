import 'package:flutter/material.dart';

class ExcptionWidget extends StatelessWidget {
  final IconData icondata;
  final String message;
  const ExcptionWidget(
      {super.key, required this.icondata, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icondata,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          message,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }
}

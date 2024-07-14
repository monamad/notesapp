//create DoneButton widget
import 'package:flutter/material.dart';

class DoneButton extends StatelessWidget {
  final int color;
  final void Function()? onPressed;
  const DoneButton({super.key, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 8, bottom: 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            decoration: _decoration(),
            width: 60,
            height: 40,
            child: Center(
              child: Text(
                'Done',
                style: TextStyle(
                  color: Color(color),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    );
  }
}

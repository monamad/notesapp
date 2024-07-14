import 'package:flutter/material.dart';

class InWordSection extends StatelessWidget {
  final String text;
  final int color;

  final bool isarabic;
  final Function()? removeword;
  const InWordSection(
      {super.key,
      required this.text,
      this.removeword,
      required this.color,
      required this.isarabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: (isarabic)
                ? Text(
                    'ar',
                    style: TextStyle(fontSize: 14, color: Color(color)),
                  )
                : Text(
                    'en',
                    style: TextStyle(fontSize: 14, color: Color(color)),
                  ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          (removeword != null)
              ? IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                  onPressed: removeword,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

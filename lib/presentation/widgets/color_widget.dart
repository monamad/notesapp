import 'package:flutter/material.dart';
import 'package:wordapp/logic/write_cubit/write_cubit_cubit.dart';

class ColorWidget extends StatelessWidget {
  final int selectedColor;
  final List<int> backgroundColorCodes = const [
    0xFFFF0000,
    0xFF808080, // Gray
    0xFF800000, // Maroon
    0xFF008000, // Dark Green
    0xFF808000, // Olive
    0xFF000080, // Navy
    0xFF800080, // Purple
    0xFF008080, // Teal
  ];
  const ColorWidget({super.key, required this.selectedColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          scrollDirection: Axis.horizontal,
          itemCount: backgroundColorCodes.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              WriteCubit.get(context).updateColor(backgroundColorCodes[index]);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: backgroundColorCodes[index] == selectedColor
                    ? Border.all(color: Colors.white, width: 2)
                    : null,
                color: Color(backgroundColorCodes[index]),
              ),
              child: backgroundColorCodes[index] == selectedColor
                  ? const Icon(Icons.check)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

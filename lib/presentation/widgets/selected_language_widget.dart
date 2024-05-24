import 'package:flutter/material.dart';
import 'package:wordapp/logic/write_cubit/write_cubit_cubit.dart';

class SelectedLanguageWidget extends StatelessWidget {
  const SelectedLanguageWidget(
      {super.key, required this.isArabic, required this.backgroundColorCodes});
  final bool isArabic;
  final int backgroundColorCodes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [languageBox(true, context), languageBox(false, context)],
    );
  }

  Widget languageBox(isArabicbox, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          WriteCubit.get(context).updateIsArabic(isArabicbox);
        },
        child: Container(
          width: 50,
          height: 80,
          decoration: BoxDecoration(
            color: (isArabicbox == isArabic) ? Colors.white : null,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: isArabicbox
                ? Text(
                    'ar',
                    style: TextStyle(
                        color: (isArabicbox == isArabic)
                            ? Color(backgroundColorCodes)
                            : null),
                  )
                : Text('en',
                    style: TextStyle(
                        color: (isArabicbox == isArabic)
                            ? Color(backgroundColorCodes)
                            : null)),
          ),
        ),
      ),
    );
  }
}

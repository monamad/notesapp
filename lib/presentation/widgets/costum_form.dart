import 'package:flutter/material.dart';
import 'package:wordapp/logic/write_cubit/write_cubit_cubit.dart';

class CostumForm extends StatefulWidget {
  final String label;
  final GlobalKey formKey;
  const CostumForm({super.key, required this.label, required this.formKey});

  @override
  State<CostumForm> createState() => _CostumFormState();
}

class _CostumFormState extends State<CostumForm> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          key: widget.formKey,
          child: TextFormField(
            autofocus: true,
            controller: _controller,
            onChanged: (value) => WriteCubit.get(context).updateWord(value),
            validator: (value) {
              return _validate(value, WriteCubit.get(context).isarabic);
            },
            decoration: custominputBorder(),
            style: const TextStyle(color: Colors.white),
          )),
    );
  }

  String? _validate(String? value, isArabic) {
    if (value!.isEmpty) {
      return 'Please enter some text';
    }
    for (int i = 0; i < value.length; i++) {
      if (getchartype(value.codeUnitAt(i)) == CharacterType.notvalid) {
        return 'letter ${i + 1} not valid';
      } else if (getchartype(value.codeUnitAt(i)) == CharacterType.arabic &&
          !isArabic) {
        return 'Please enter only English letters';
      } else if (getchartype(value.codeUnitAt(i)) == CharacterType.english &&
          isArabic) {
        return 'Please enter only Arabic letters';
      }
    }
    return null;
  }

  CharacterType getchartype(int asciicode) {
    if (asciicode >= 65 && asciicode <= 90 ||
        asciicode >= 97 && asciicode <= 122) {
      return CharacterType.english;
    } else if (asciicode >= 1536 && asciicode <= 1791) {
      return CharacterType.arabic;
    } else if (asciicode == 32) {
      return CharacterType.space;
    } else {
      return CharacterType.notvalid;
    }
  }

  InputDecoration custominputBorder() {
    return InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ));
  }
}

enum CharacterType { arabic, english, space, notvalid }

import 'package:flutter/material.dart';

class BuildTextFormField extends StatelessWidget {
  const BuildTextFormField({
    super.key,
    required this.textController,
    required this.validator,
    required this.maxLines,
    required this.labelText,
  });

  final TextEditingController textController;
  final String? Function(String?) validator;
  final int maxLines;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: const TextStyle(color: Colors.blue),
      cursorColor: Colors.red,
      controller: textController,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}

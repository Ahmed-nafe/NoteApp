import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  BuildTextField({
    super.key,
    required this.text,
    required this.x,
  });

  int x;

  final TextEditingController text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: x,
      controller: text,
      decoration: InputDecoration(
        labelText: "Title",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
    );
  }
}

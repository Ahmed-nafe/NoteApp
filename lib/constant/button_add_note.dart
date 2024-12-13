import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../firebase/firebase_function.dart';
import '../model/note_model.dart';

class ButtonAddNote extends StatelessWidget {
  const ButtonAddNote({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.selectedColor,
    required this.noteNameController,
    required this.descriptionController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final Color? selectedColor;
  final TextEditingController noteNameController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          if (selectedColor == null) {
            Fluttertoast.showToast(
              msg: "Please select a color",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            return;
          }
          final newNote = NoteModel(
              id: "",
              title: noteNameController.text,
              description: descriptionController.text,
              color: selectedColor != null
                  ? selectedColor!.value.toRadixString(16)
                  : 'ffffff');
          await FirebaseFunction.addTask(newNote);
          Navigator.pop(context);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        minimumSize: const Size(double.infinity, 50),
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            color: Colors.white,
          ),
          Text(
            'Add New Note',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

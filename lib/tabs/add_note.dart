import 'package:flutter/material.dart';
import '../constant/constant.dart';
import '../constant/build_text_form_field.dart';
import '../constant/custom_app_bar.dart';
import '../constant/button_add_note.dart';

class AddNoteItem extends StatefulWidget {
  const AddNoteItem({super.key});

  @override
  State<AddNoteItem> createState() => _AddNoteItemState();
}

class _AddNoteItemState extends State<AddNoteItem> {
  TextEditingController noteNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Color? selectedColor;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          width: double.infinity,
          child: CustomAppBar(heightSize: heightSize),
        ),
        Padding(
          padding: EdgeInsets.all(widthSize * 0.03),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: heightSize * 0.03),
                BuildTextFormField(
                  labelText: "NoteName",
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please Enter a NoteName ";
                    }
                    if (value.length <= 3) {
                      return "please Note Name Must be at least 3 characters ";
                    }
                    return null;
                  },
                  textController: noteNameController,
                ),
                const SizedBox(
                  height: 25,
                ),
                BuildTextFormField(
                  labelText: "Description",
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please Enter a Description ";
                    }
                    if (value.length <= 10) {
                      return "please Note Description Must be at least 10 characters ";
                    }
                    return null;
                  },
                  textController: descriptionController,
                ),
                SizedBox(height: heightSize * 0.03),
                const Text('Note Color (Customize)',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: heightSize * 0.01),
                Wrap(
                  spacing: 10.0,
                  children: Shared.habitColors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: color,
                        child: selectedColor == color
                            ? const Icon(Icons.check_circle,
                                color: Colors.green)
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: heightSize * 0.019),
                ButtonAddNote(
                  formKey: _formKey,
                  selectedColor: selectedColor,
                  noteNameController: noteNameController,
                  descriptionController: descriptionController,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}


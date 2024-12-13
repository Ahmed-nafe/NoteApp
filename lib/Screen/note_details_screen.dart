import 'package:flutter/material.dart';
import 'package:untitled1/build_text_field.dart';
import 'package:untitled1/firebase/firebase_function.dart';
import 'package:untitled1/model/note_model.dart';

class NoteDetailsScreen extends StatefulWidget {
  final NoteModel note;

  const NoteDetailsScreen({super.key, required this.note});

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
      text: widget.note.title,
    );
    descriptionController = TextEditingController(
      text: widget.note.description,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.note.getColor(),
      appBar: AppBar(
        title: const Text("Note Details"),
        backgroundColor: widget.note.getColor(),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              final updatedNote = NoteModel(
                  id: widget.note.id,
                  color: widget.note.color,
                  title: titleController.text,
                  description: descriptionController.text);
              try {
                await FirebaseFunction.updateTask(updatedNote);
                Navigator.pop(context, updatedNote); // إعادة الكائن المحدث
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Failed to update note: $e")),
                );
              }
            },
          ),
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete Confirm"),
                      content: const Text(
                        "Are you sure you want to delete this item?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("cancel"),
                        ),
                        TextButton(
                          onPressed: () async {
                            final deleteNote = widget.note.id;
                            await FirebaseFunction.deleteNote(deleteNote);
                            Navigator.pop(
                              context,
                            );
                            Navigator.pop(
                              context,
                            );
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BuildTextField(text: titleController, x: 1),
            const SizedBox(height: 16),
            BuildTextField(text: descriptionController, x: 5),
          ],
        ),
      ),
    );
  }
}

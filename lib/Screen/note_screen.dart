import 'package:flutter/material.dart';
import 'package:untitled1/model/note_model.dart';
import 'package:untitled1/tabs/add_note.dart';
import '../tabs/search_tab.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: const AddNoteItem());
              },
            );
          },
          backgroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
        body: SearchTab(),
      ),
    );
  }
}

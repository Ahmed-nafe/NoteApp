import 'package:flutter/material.dart';
import 'package:untitled1/firebase/firebase_function.dart';
import '../model/note_model.dart';
import 'build_note_item.dart';

class BuildNote extends StatefulWidget {
  const BuildNote({
    super.key,
    // required this.notes
  });

  // final List<NoteModel> notes;

  @override
  State<BuildNote> createState() => _BuildNoteState();
}

class _BuildNoteState extends State<BuildNote> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFunction.getNote();
  }

  @override
  Widget build(BuildContext context) {
    return const BuildNoteItem();
  }
}
// }

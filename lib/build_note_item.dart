import 'package:flutter/material.dart';
import 'package:untitled1/Screen/note_details_screen.dart';
import 'package:untitled1/firebase/firebase_function.dart';
import 'model/note_model.dart';

class BuildNoteItem extends StatefulWidget {
  const BuildNoteItem({
    super.key,
  });

  @override
  State<BuildNoteItem> createState() => _BuildNoteItemState();
}

class _BuildNoteItemState extends State<BuildNoteItem> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFunction.getNoteCollection().snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Something Went Error"));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/notes.png",
                width: 100,
              ),
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: Text(
                  "No notes available, Add one!",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          );
        }
        var notes = snapshot.data!.docs.map((e) => e.data()).toList();
        return GridView.builder(
          itemCount: notes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 7,
          ),
          itemBuilder: (context, index) {
            final note = notes[index];
            return InkWell(
              onTap: () async {
                final updatedNote = await Navigator.push<NoteModel>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteDetailsScreen(
                      note: note,
                    ),
                  ),
                );
                // if (updatedNote != null) {
                //   setState(() {
                //     notes[index] = updatedNote;
                //   });
                // }
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: note.getColor(),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      note.title,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(note.description),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

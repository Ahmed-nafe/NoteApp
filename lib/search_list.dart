import 'package:flutter/material.dart';

import 'Screen/note_details_screen.dart';
import 'model/note_model.dart';

class ListSearchData extends StatelessWidget {
  const ListSearchData({
    super.key,
    required List<NoteModel> searchResults,
  }) : _searchResults = searchResults;

  final List<NoteModel> _searchResults;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final note = _searchResults[index];
        return ListTile(
          leading: const Icon(Icons.note),
          title: Text(note.title),
          subtitle: Text(note.description),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NoteDetailsScreen(note: note);
            }));
          },
        );
      },
    );
  }
}

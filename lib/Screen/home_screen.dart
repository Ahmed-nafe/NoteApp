
import 'package:flutter/material.dart';
import 'package:untitled1/Screen/note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NoteScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
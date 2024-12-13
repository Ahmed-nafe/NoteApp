import 'package:flutter/material.dart';
import 'package:untitled1/firebase/firebase_function.dart';
import 'package:untitled1/model/note_model.dart';
import '../build_note.dart';
import '../search_list.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  bool _isExpanded = false;
  final TextEditingController _controller = TextEditingController();
  List<NoteModel> _searchResults = [];
  bool _isLoading = false;

  void _searchNotes(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final results = await FirebaseFunction.searchNotes(query);
    setState(() {
      _searchResults = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          margin: const EdgeInsets.all(10),
          duration: const Duration(milliseconds: 300),
          height: _isExpanded ? 400 : 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Column(
              children: [
                if (!_isExpanded)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, size: 30, color: Colors.grey),
                          Text(
                            "Search Notes",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage("assets/IMG-20240711-WA0007.jpg"),
                          )
                        ],
                      ),
                    ),
                  ),

                if (_isExpanded)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _controller,
                                    decoration: InputDecoration(
                                      hintText: 'Search notes',
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      prefixIcon: IconButton(
                                        icon: const Icon(Icons.arrow_back),
                                        onPressed: () => setState(() {
                                          _isExpanded = false;
                                          _controller.clear();
                                          _searchResults.clear();
                                        }),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.mic),
                                        onPressed: () {},
                                      ),
                                    ),
                                    onChanged: _searchNotes,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text('Type',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildOption('Images', Icons.image),
                                _buildOption('Drawings', Icons.brush),
                                _buildOption('Links', Icons.link),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text('Search Result',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : _searchResults.isEmpty
                                    ? const Center(
                                        child: Text(
                                          'No results found.',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      )
                                    : ListSearchData(
                                        searchResults: _searchResults,
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const Expanded(
          child: BuildNote(),
        ),
      ],
    );
  }

  Widget _buildOption(String label, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.purple[100],
          child: Icon(icon, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

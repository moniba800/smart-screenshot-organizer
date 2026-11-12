import 'package:flutter/material.dart';
import 'data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String query = '';
  String? selectedCategory; // null = All

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Shot> get results {
    final cats = categories;
    final active = (selectedCategory != null && cats.contains(selectedCategory))
        ? selectedCategory
        : null;
    final q = query.trim().toLowerCase();

    return shots.where((s) {
      final matchCategory = active == null || s.category == active;
      final matchText = q.isEmpty ||
          s.title.toLowerCase().contains(q) ||
          s.category.toLowerCase().contains(q) ||
          s.tags.any((t) => t.toLowerCase().contains(q));
      return matchCategory && matchText;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = results;
    final cats = categories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              onChanged: (v) => setState(() => query = v),
              onSubmitted: (v) {
                if (v.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please enter a search term')),
                  );
                }
              },
              decoration: InputDecoration(
                hintText: 'Search by name, category or tag',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: query.isEmpty
                    ? null
                    : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    setState(() => query = '');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: const Text('All'),
                    selected: selectedCategory == null,
                    onSelected: (_) =>
                        setState(() => selectedCategory = null),
                  ),
                ),
                ...cats.map(
                      (c) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(c),
                      selected: selectedCategory == c,
                      onSelected: (_) =>
                          setState(() => selectedCategory = c),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${items.length} result(s)',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('No results found'))
                : ShotGrid(
              items: items,
              onChanged: () => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredShots = shots.where((shot) {
      return shot.title.toLowerCase().contains(
        searchQuery.toLowerCase(),
      ) ||
          shot.category.toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          shot.tags.any(
                (tag) => tag.toLowerCase().contains(
              searchQuery.toLowerCase(),
            ),
          );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Screenshots',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search screenshots...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      searchQuery = '';
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          Expanded(
            child: filteredShots.isEmpty
                ? const Center(
              child: Text(
                'No screenshots found',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
                : ShotGrid(
              items: filteredShots,
              onChanged: () {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}

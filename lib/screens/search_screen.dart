import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Center(
        child: TextField(
          onChanged: (text) {
            // Perform search logic here
            print('Search query: $text');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Perform search action here
          print('Search button pressed');
        },
        child: Icon(Icons.search),
      ),
    );
  }
}

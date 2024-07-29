
import 'package:eventique_shreek/core/resources/color.dart';
import 'package:eventique_shreek/widgets/search_tile.dart';
import 'package:flutter/material.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _searchResults = [];
  final List<String> _items = [
    'Dream Cake',
    'Salad',
    'Royal Hall',
    'Batata',
    'Bandora',
    'Red Roses',
    'Taboleh',
    'Lala Photography'
  ];

  void _onSearchChanged(String text) {
    setState(() {
      _searchResults = _items
          .where((item) => item.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: TextField(
            style: Theme.of(context).textTheme.bodyMedium,
            controller: _controller,
            onChanged: (text) {
              _onSearchChanged(text);
            },
            decoration: InputDecoration(
              constraints:
                  BoxConstraints(maxWidth: mediaq.width * 0.87, maxHeight: 45),
              hintText: 'Search...',
              hintStyle: const TextStyle(
                fontFamily: 'IrishGrover',
                color: Color.fromARGB(255, 227, 181, 193),
              ),
              prefixIconColor: const Color.fromARGB(255, 226, 147, 168),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 8),
                child: Icon(Icons.search, size: 26),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 226, 147, 168)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Color(0xff662465)),
              ),
              filled: false,
            ),
          ),
        ),
      ),
      body: _controller.text.isEmpty
          ? Container() // Blank page
          : ListView.builder(padding: EdgeInsets.symmetric(vertical: 20),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return SearchTile(
                  serviceName: _searchResults[index],
                  serviceUrl: 'https://i.postimg.cc/jSD6s14x/photo-2024-04-25-23-30-29.jpg',
                  serviceId: 1,
                  serviceCompany: 'Bee',
                );
              },
            ),
    );
  }
}

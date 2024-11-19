import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final String dataSearch;
  const Search({super.key, required this.dataSearch});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

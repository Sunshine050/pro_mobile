import 'package:flutter/material.dart';

class SearchButton extends StatefulWidget {
  @override
  _SearchButtonState createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: _isExpanded ? 200 : 0, // Adjust the width as needed
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}

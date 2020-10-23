import 'package:flutter/material.dart';
import 'package:news_app/utils/constants.dart';

class Search extends StatelessWidget {
  const Search({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.search),
        hintText: 'Search for news, topics...',
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ),
        fillColor: kColorSecondaryDark,
      ),
    );
  }
}

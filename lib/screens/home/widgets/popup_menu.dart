import 'package:flutter/material.dart';

class PopupMenu extends StatefulWidget {
  const PopupMenu({
    Key key,
    @required String selection,
  })  : _selection = selection,
        super(key: key);

  final String _selection;

  @override
  _PopupMenuState createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  String selection;

  @override
  void initState() {
    super.initState();
    selection = widget._selection;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      child: Row(
        children: [
          Text('Sort: $selection'),
          Icon(Icons.arrow_drop_down),
        ],
      ),
      onSelected: (String value) {
        setState(() {
          selection = value;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Popular',
          child: Text('Popular'),
        ),
        const PopupMenuItem<String>(
          value: 'Newest',
          child: Text('Newest'),
        ),
        const PopupMenuItem<String>(
          value: 'Oldest',
          child: Text('Oldest'),
        ),
      ],
    );
  }
}

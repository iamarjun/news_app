import 'package:flutter/material.dart';
import 'package:news_app/models/sources.dart';
import 'package:news_app/utils/constants.dart';

class SourceBottomSheet extends StatefulWidget {
  final List<Sources> source;
  final Function onPressed;
  const SourceBottomSheet({
    Key key,
    @required this.source,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _SourceBottomSheetState createState() => _SourceBottomSheetState();
}

class _SourceBottomSheetState extends State<SourceBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 5.0,
              indent: 130.0,
              endIndent: 130.0,
              color: Colors.black12,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Filter by sources',
              style: TextStyle(
                fontSize: 22.0,
                color: kColorPrimaryDark,
              ),
            ),
            Divider(
              thickness: 1.0,
              color: Colors.black12,
            ),
            Expanded(
              child: ListView(
                children: widget.source
                    .map(
                      (e) => CheckboxListTile(
                        onChanged: (bool value) {
                          setState(() {
                            e.setSelected = value;
                          });
                        },
                        value: e.isSelected,
                        title: Text(e.name),
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => widget.onPressed(
                  widget.source.where((element) => element.isSelected).toList(),
                ),
                child: Text('Apply Filters'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_app/models/country.dart';
import 'package:news_app/utils/constants.dart';

class LocationBottomSheet extends StatelessWidget {
  final index;
  final List<Country> countryList;
  final Function onChanged;
  const LocationBottomSheet({
    Key key,
    this.index,
    @required this.countryList,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(index);
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
              'Choose your location',
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
                children: countryList
                    .map(
                      (e) => RadioListTile(
                        title: Text(e.name),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: countryList.indexOf(e),
                        groupValue: index,
                        onChanged: (value) => onChanged(value, e),
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
                onPressed: () {},
                child: Text('Apply'),
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

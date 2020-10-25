import 'package:flutter/material.dart';
import 'package:news_app/models/country.dart';
import 'package:news_app/models/data_holder.dart';
import 'package:news_app/utils/constants.dart';

class LocationBottomSheet extends StatefulWidget {
  final LocationDataHolder dataHolder;
  final Function onPressed;
  const LocationBottomSheet(
      {Key key,
      @required this.dataHolder,
      @required this.onPressed})
      : super(key: key);

  @override
  _LocationBottomSheetState createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  Country _currentCountry;

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
                children: widget.dataHolder.countries
                    .map(
                      (e) => RadioListTile(
                        title: Text(e.name),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: e.index,
                        groupValue: widget.dataHolder.selectedCountryIndex,
                        onChanged: (value) {
                          setState(() {
                            widget.dataHolder.selectedCountryIndex = e.index;
                          });
                          _currentCountry = e;
                        },
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
                onPressed: () => widget.onPressed(_currentCountry),
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

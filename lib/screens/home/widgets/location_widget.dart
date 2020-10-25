import 'package:flutter/material.dart';

class LocationInkWell extends StatefulWidget {
  const LocationInkWell({
    Key key,
    @required this.onTap,
    @required this.location,
  }) : super(key: key);

  final Function onTap;
  final String location;

  @override
  _LocationInkWellState createState() => _LocationInkWellState();
}

class _LocationInkWellState extends State<LocationInkWell> {
  String location;

  @override
  void initState() {
    super.initState();
    location = widget.location;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Location'),
            SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.location_on,
                  size: 15,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(location),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

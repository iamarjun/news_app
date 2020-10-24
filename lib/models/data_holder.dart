import 'package:news_app/models/country.dart';

class LocationDataHolder {
  List<Country> countries;
  int selectedCountryIndex;

  LocationDataHolder._();
  static final LocationDataHolder _instance = LocationDataHolder._();

  factory LocationDataHolder(
      {List<Country> countries, int selectedCountryIndex}) {
    _instance.countries = countries;
    _instance.selectedCountryIndex = selectedCountryIndex;

    return _instance;
  }
}

import 'package:news_app/models/country.dart';

class LocationDataHolder {
  List<Country> countries;
  int selectedCountryIndex;
  String currentCountryCode;

  set setCurrentCountryCode(String value) {
    currentCountryCode = value;
    selectedCountryIndex = countries.indexWhere(
      (element) => element.code == value.toLowerCase(),
    );
  }

  LocationDataHolder._();
  static final LocationDataHolder _instance = LocationDataHolder._();

  factory LocationDataHolder(
      {List<Country> countries, int selectedCountryIndex}) {
    _instance.countries = countries;
    _instance.selectedCountryIndex = selectedCountryIndex;
    return _instance;
  }
}

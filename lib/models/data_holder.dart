import 'package:geocoding/geocoding.dart';
import 'package:news_app/models/country.dart';

class LocationDataHolder {
  List<Country> countries;
  int selectedCountryIndex;
  Placemark currentCountry;

  set setCurrentCountry(Placemark country) {
    currentCountry = country;
    selectedCountryIndex = countries.indexWhere(
      (element) => element.code == currentCountry.isoCountryCode.toLowerCase(),
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

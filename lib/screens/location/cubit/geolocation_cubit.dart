import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:news_app/service/location/geo_location.dart';

part 'geolocation_state.dart';

class GeolocationCubit extends Cubit<GeolocationState> {
  final GeoLocation location;
  GeolocationCubit({this.location}) : super(GeolocationInitial());

  Future<void> getCountryCode() async {
    try {
      emit(GeolocationInitial());
      Placemark country = await location.getCurrentCountry();
      emit(GeolocationSuccess(country: country));
    } catch (e) {
      emit(GeolocationFailure());
    }
  }
}

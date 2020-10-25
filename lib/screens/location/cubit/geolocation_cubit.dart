import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/service/location/geo_location.dart';

part 'geolocation_state.dart';

class GeolocationCubit extends Cubit<GeolocationState> {
  final GeoLocation location;
  GeolocationCubit({this.location}) : super(GeolocationInitial());

  Future<void> getCountryCode() async {
    try {
      emit(GeolocationInitial());
      String countryCode = await location.getCurrentCountry();
      emit(GeolocationSuccess(countryCode: countryCode));
    } catch (e) {
      emit(GeolocationFailure());
    }
  }
}

part of 'geolocation_cubit.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object> get props => [];
}

class GeolocationInitial extends GeolocationState {}

class GeolocationFailure extends GeolocationState {}

class GeolocationSuccess extends GeolocationState {
  final String countryCode;

  const GeolocationSuccess({this.countryCode});

  @override
  List<Object> get props => [countryCode];
}

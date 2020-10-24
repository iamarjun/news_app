part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationFailure extends LocationState {}

class LocationSuccess extends LocationState {
  final LocationDataHolder dataHolder;

  const LocationSuccess({this.dataHolder});

  @override
  List<Object> get props => [dataHolder];
}

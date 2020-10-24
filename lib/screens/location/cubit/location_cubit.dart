import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/models/data_holder.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationDataHolder dataHolder;
  LocationCubit({this.dataHolder}) : super(LocationInitial());

  Future<void> getCountries() {
    try {
      emit(LocationInitial());
      emit(LocationSuccess(dataHolder: dataHolder));
    } catch (e) {
      emit(LocationFailure());
    }
  }
}

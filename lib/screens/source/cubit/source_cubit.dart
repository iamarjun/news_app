import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/models/sources.dart';
import 'package:news_app/service/api_service.dart';

part 'source_state.dart';

class SourceCubit extends Cubit<SourceState> {
  final ApiService service;
  SourceCubit({this.service}) : super(SourceInitial());

  Future<void> getSources() async {
    try {
      emit(SourceInitial());
      final response = await service.getSource();
      emit(SourceSuccess(sources: response.sources));
    } catch (e) {
      emit(SourceFailure());
    }
  }
}

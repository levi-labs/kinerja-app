import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:kinerja_app/models/nilai_form_model.dart';
import 'package:kinerja_app/models/nilai_form_create_model.dart';
import 'package:kinerja_app/services/nilai_service.dart';

part 'nilai_event.dart';
part 'nilai_state.dart';

class NilaiBloc extends Bloc<NilaiEvent, NilaiState> {
  NilaiBloc() : super(NilaiInitial()) {
    on<NilaiEvent>((event, emit) async {
      if (event is NilaiLoadedEvent) {
        emit(NilaiLoadingState());
        try {
          final data = await NilaiService().getNilai();
          emit(NilaiLoadedState(data));
        } catch (e) {
          emit(NilaiErrorState(e.toString()));
        }
      }

      if (event is NilaiCreateByDateEvent) {
        emit(NilaiLoadingState());
        try {
          final data = await NilaiService().createNilaiByDate(event.date);

          emit(NilaiShowByDateState(data));
        } catch (e) {
          emit(NilaiErrorState(e.toString()));
        }
      }
    });
  }
}

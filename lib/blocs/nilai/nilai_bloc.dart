import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kinerja_app/models/nilai_form_by_date_model.dart';
import 'package:kinerja_app/models/nilai_form_edit_model.dart';
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
      if (event is NilaiShowByDateEvent) {
        emit(NilaiLoadingState());
        try {
          final data = await NilaiService().getNilaiByDate(event.date);
          emit(NilaiLoadedByDateState(data));
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

      if (event is NilaiCreateDataEvent) {
        emit(NilaiLoadingState());
        try {
          await NilaiService().storeNilai(event.idPegawai, event.controllerId,
              event.controllerNilai, event.tanggalNilai);
          emit(NilaiCreateSuccessState());
        } catch (e) {
          emit(NilaiErrorState(e.toString()));
        }
      }

      if (event is NIlaiEditByIdAndDateEvent) {
        emit(NilaiLoadingState());
        try {
          final data = await NilaiService()
              .editNilaiByIdAndDate(event.idPegawai, event.date);
          emit(NilaiLoadedByIdPegawaiAndDateState(data));
        } catch (e) {
          emit(NilaiErrorState(e.toString()));
        }
      }
      if (event is NilaiUpdateDataEvent) {
        emit(NilaiLoadingState());
        try {
          await NilaiService().updateNilaiByIdAndDate(
            event.indikatorId,
            event.nilaiId,
            event.inputNilai,
          );
          emit(NilaiUpdateSuccessState());
        } catch (e) {
          emit(NilaiErrorState(e.toString()));
        }
      }
      if (event is NilaiDeleteByIdAndDateEvent) {
        emit(NilaiLoadingState());
        try {
          await NilaiService()
              .deleteNilaiByIdAndDate(event.idPegawai, event.date);
          emit(NilaiDeleteSuccessState());
        } catch (e) {
          emit(NilaiErrorState(e.toString()));
        }
      }
    });
  }
}

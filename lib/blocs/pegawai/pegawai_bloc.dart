import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kinerja_app/models/pegawai_form_model.dart';
import 'package:kinerja_app/services/auth_service.dart';
import 'package:kinerja_app/services/pegawai_service.dart';

part 'pegawai_event.dart';
part 'pegawai_state.dart';

class PegawaiBloc extends Bloc<PegawaiEvent, PegawaiState> {
  PegawaiBloc() : super(PegawaiInitial()) {
    on<PegawaiEvent>((event, emit) async {
      if (event is PegawaiLoadedEvent) {
        emit(PegawaiLoadingState());
        try {
          final data = await PegawaiService().getPegawai();
          emit(PegawaiLoadedState(data));
        } catch (e) {
          emit(PegawaiErrorState(e.toString()));
        }
      }

      if (event is PegawaiCreatedEvent) {
        emit(PegawaiLoadingState());
        try {
          await PegawaiService().createPegawai(event.data);
          emit(PegawaiCreatedSuccessState());
        } catch (e) {
          emit(PegawaiErrorState(e.toString()));
        }
      }

      if (event is PegawaiShowByIdEvent) {
        try {
          final data = await PegawaiService().getPegawaiById(event.id);
          emit(PegawaiGetByIdSuccessState(data));
        } catch (e) {
          emit(PegawaiErrorState(e.toString()));
        }
      }

      if (event is PegawaiUpdatedEvent) {
        emit(PegawaiLoadingState());
        // try {
        //   await PegawaiService().createPegawai(event.data);
        //   emit(PegawaiUpdatedSuccessState());
        // } catch (e) {
        //   emit(PegawaiErrorState(e.toString()));
        // }
      }
    });
  }
}

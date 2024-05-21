import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kinerja_app/models/kriteria_form_model.dart';
import 'package:kinerja_app/services/kritria_service.dart';

part 'kriteria_event.dart';
part 'kriteria_state.dart';

class KriteriaBloc extends Bloc<KriteriaEvent, KriteriaState> {
  KriteriaBloc() : super(KriteriaInitial()) {
    on<KriteriaEvent>((event, emit) async {
      // TODO: implement event handler

      if (event is KriteriaGet) {
        try {
          final response = await KriteriaService().getKriteria();
          emit(KriteriaLoaded(response));
        } catch (e) {
          emit(KriteriaFailed(e.toString()));
        }
      }

      if (event is KriteriaAdd) {
        try {
          emit(KriteriaLoading());
          var response = await KriteriaService().createKriteria(event.data);

          emit(KriteriaAddSuccess());
        } catch (e) {
          emit(KriteriaFailed(e.toString()));
        }
      }

      if (event is KriteriaGetById) {
        try {
          final response = await KriteriaService().getKriteriaById(event.id);

          emit(KriteriaLoadedById(response));
        } catch (e) {
          emit(KriteriaFailed(e.toString()));
        }
      }

      if (event is KriteriaUpdate) {
        try {
          emit(KriteriaLoading());
          await KriteriaService().updateKriteria(event.data);
          emit(KriteriaUpdateSuccess());
        } catch (e) {
          emit(KriteriaFailed(e.toString()));
        }
      }

      if (event is KriteriaDelete) {
        try {
          emit(KriteriaLoading());
          var response = await KriteriaService().deleteKriteria(event.id);
          emit(KriteriaDeleteSuccess());
        } catch (e) {
          emit(KriteriaFailed(e.toString()));
        }
      }
    });
  }
}

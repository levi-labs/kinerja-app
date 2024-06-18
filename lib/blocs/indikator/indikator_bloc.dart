import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kinerja_app/models/indikator_form_model.dart';
import 'package:kinerja_app/services/indikator_service.dart';

part 'indikator_event.dart';
part 'indikator_state.dart';

class IndikatorBloc extends Bloc<IndikatorEvent, IndikatorState> {
  IndikatorBloc() : super(IndikatorStateInitial()) {
    on<IndikatorEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GetEventIndikator) {
        try {
          emit(IndikatorStateLoading());
          final response = await IndikatorService().getIndikator();
          emit(IndikatorStateLoaded(response));
        } catch (e) {
          emit(IndikatorStateFailed(e.toString()));
        }
      }
      if (event is GetEventIndikatorById) {
        try {
          emit(IndikatorStateLoading());
          final response = await IndikatorService().getIndikatorById(event.id);
          emit(IndikatorStateLoadedById(response));
        } catch (e) {
          emit(IndikatorStateFailed(e.toString()));
        }
      }

      if (event is GetEventIndikatorByKriteria) {
        try {
          emit(IndikatorStateLoading());
          final response =
              await IndikatorService().getGrupIndikatorById(event.id);

          emit(IndikatorStateLoadedByKriteriaId(response));
        } catch (e) {
          emit(IndikatorStateFailed(e.toString()));
        }
      }

      if (event is AddEventIndikator) {
        try {
          emit(IndikatorStateLoading());
          await IndikatorService().createIndikator(event.data);
          emit(IndikatorStateAdded());
        } catch (e) {
          emit(IndikatorStateFailed(e.toString()));
        }
      }

      if (event is UpdateEventIndikator) {
        try {
          emit(IndikatorStateLoading());
          await IndikatorService().updateIndikator(event.data);
          emit(IndikatorStateUpdated());
        } catch (e) {
          emit(IndikatorStateFailed(e.toString()));
        }
      }
      if (event is DeleteEventIndikator) {
        try {
          emit(IndikatorStateLoading());
          await IndikatorService().deleteIndikator(event.id);
          emit(IndikatorStateDeleted());
        } catch (e) {
          emit(IndikatorStateFailed(e.toString()));
        }
      }
    });
  }
}

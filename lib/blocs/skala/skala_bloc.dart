import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kinerja_app/models/skala_from_model.dart';
import 'package:kinerja_app/services/skala_service.dart';
part 'skala_event.dart';
part 'skala_state.dart';

class SkalaBloc extends Bloc<SkalaEvent, SkalaState> {
  SkalaBloc() : super(SkalaInitial()) {
    on<SkalaEvent>((event, emit) async {
      if (event is SkalaEventGet) {
        try {
          emit(SkalaStateLoading());
          final response = await SkalaService().getSkala();
          emit(SkalaStateLoaded(response));
        } catch (e) {
          emit(SkalaStateError(e.toString()));
        }
      }
      if (event is SkalaEventAdd) {
        try {
          emit(SkalaStateLoading());
          await SkalaService().createSkala(event.data);
          emit(SkalaStateAdded());
        } catch (e) {
          emit(SkalaStateError(e.toString()));
        }
      }

      if (event is SkalaEventGetById) {
        try {
          emit(SkalaStateLoading());
          final response = await SkalaService().getSkalaById(event.id);
          emit(SkalaStateGetById(response));
        } catch (e) {
          emit(SkalaStateError(e.toString()));
        }
      }

      if (event is SkalaEventUpdate) {
        try {
          emit(SkalaStateLoading());
          await SkalaService().updateSkala(event.data);
          emit(SkalaStateUpdated());
        } catch (e) {
          emit(SkalaStateError(e.toString()));
        }
      }

      if (event is SkalaEventDelete) {
        try {
          emit(SkalaStateLoading());
          await SkalaService().deleteSkala(event.id);
          emit(SkalaStateDeleted());
        } catch (e) {
          emit(SkalaStateError(e.toString()));
        }
      }
    });
  }
}

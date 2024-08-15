import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kinerja_app/models/dashboard_form_model.dart';
import 'package:kinerja_app/services/dashboard_service.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is DashboardGet) {
        try {
          emit(DashboardLoading());
          var dashboard = await DashboardService().getDashboard();
          emit(DashboardLoaded(dashboard));
        } catch (e) {
          emit(DashboardError(e.toString()));
        }
      }
    });
  }
}

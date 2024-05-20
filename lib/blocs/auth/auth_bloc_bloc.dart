import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kinerja_app/models/dashboard_form_model.dart';
import 'package:kinerja_app/models/login_form_model.dart';
import 'package:kinerja_app/models/user_form_model.dart';
import 'package:kinerja_app/services/auth_service.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthBlocEvent>((event, emit) async {
      // TODO: implement event handler

      if (event is AuthLogin) {
        try {
          emit(AuthLoading());
          final user = await AuthService().login(event.data);

          emit(AuthLoginSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());

          final data = await AuthService().getCurrentCredentials();
          final UserModel user = await AuthService().login(data);

          emit(AuthLoginSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogout) {
        try {
          emit(AuthLoading());
          await AuthService().logout();
          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
    });
  }
}

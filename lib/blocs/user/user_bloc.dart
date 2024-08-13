import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kinerja_app/models/user_form_model.dart';
import 'package:kinerja_app/services/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is GetUserEvent) {
        emit(UserLoadingState());
        try {
          final response = await UserService().getUser();
          emit(UserLoadedState(response));
        } catch (e) {
          emit(UserErrorState(e.toString()));
        }
      }

      if (event is AddUserEvent) {
        emit(UserLoadingState());
        try {
          await UserService().createUser(event.data);
          emit(UserSuccessState());
        } catch (e) {
          emit(UserErrorState(e.toString()));
        }
      }
      if (event is GetUserByIdEvent) {
        emit(UserLoadingState());
        try {
          final response = await UserService().getUserById(event.id);
          emit(UserGetByIdSuccessState(response));
        } catch (e) {
          emit(UserErrorState(e.toString()));
        }
      }
      if (event is UpdateUserEvent) {
        emit(UserLoadingState());
        try {
          await UserService().updateUser(event.data);
          emit(UserUpdateSuccessState());
        } catch (e) {
          emit(UserErrorState(e.toString()));
        }
      }
    });
  }
}

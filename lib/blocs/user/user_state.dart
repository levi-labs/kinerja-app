part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<UserModel> data;
  const UserLoadedState(this.data);

  @override
  List<Object> get props => [data];
}

class UserGetByIdSuccessState extends UserState {
  final UserModel data;
  const UserGetByIdSuccessState(this.data);

  @override
  List<Object> get props => [data];
}

class UserSuccessState extends UserState {}

class UserUpdateSuccessState extends UserState {}

class UserDeleteSuccessState extends UserState {}

class UserErrorState extends UserState {
  final String error;
  const UserErrorState(this.error);

  @override
  List<Object> get props => [error];
}

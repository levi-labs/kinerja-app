part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {}

class AddUserEvent extends UserEvent {
  final UserModel data;

  const AddUserEvent(this.data);

  @override
  List<Object> get props => [data];
}

class GetUserByIdEvent extends UserEvent {
  final String id;

  const GetUserByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateUserEvent extends UserEvent {
  final UserModel data;

  const UpdateUserEvent(this.data);

  @override
  List<Object> get props => [data];
}

class DeleteUserEvent extends UserEvent {
  final String id;

  const DeleteUserEvent(this.id);

  @override
  List<Object> get props => [id];
}

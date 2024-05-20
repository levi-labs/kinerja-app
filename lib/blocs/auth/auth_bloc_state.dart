part of 'auth_bloc_bloc.dart';

abstract class AuthBlocState extends Equatable {
  const AuthBlocState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class AuthLoginSuccess extends AuthBlocState {
  final UserModel user;
  const AuthLoginSuccess(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthFailed extends AuthBlocState {
  final String e;

  const AuthFailed(this.e);

  @override
  // TODO: implement props
  List<Object> get props => [e];
}

class AuthLogoutSuccess extends AuthBlocState {}

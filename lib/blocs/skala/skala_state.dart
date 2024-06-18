part of 'skala_bloc.dart';

abstract class SkalaState extends Equatable {
  const SkalaState();

  @override
  List<Object> get props => [];
}

class SkalaInitial extends SkalaState {}

class SkalaStateLoading extends SkalaState {}

class SkalaStateLoaded extends SkalaState {
  final List<SkalaFormModel> data;

  const SkalaStateLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class SkalaStateGetById extends SkalaState {
  final SkalaFormModel data;

  const SkalaStateGetById(this.data);

  @override
  List<Object> get props => [data];
}

class SkalaStateError extends SkalaState {
  final String e;

  const SkalaStateError(this.e);

  @override
  List<Object> get props => [e];
}

class SkalaStateAdded extends SkalaState {}

class SkalaStateUpdated extends SkalaState {}

class SkalaStateDeleted extends SkalaState {}

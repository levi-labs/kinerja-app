part of 'indikator_bloc.dart';

abstract class IndikatorState extends Equatable {
  const IndikatorState();

  @override
  List<Object> get props => [];
}

class IndikatorStateInitial extends IndikatorState {}

class IndikatorStateLoading extends IndikatorState {}

class IndikatorStateLoaded extends IndikatorState {
  final List<IndikatorFormModel> indikator;
  const IndikatorStateLoaded(this.indikator);

  @override
  List<Object> get props => [indikator];
}

class IndikatorStateLoadedByKriteriaId extends IndikatorState {
  final List<IndikatorFormModel> indikator;
  const IndikatorStateLoadedByKriteriaId(this.indikator);

  @override
  List<Object> get props => [indikator];
}

class IndikatorStateFailed extends IndikatorState {
  final String e;
  const IndikatorStateFailed(this.e);

  @override
  List<Object> get props => [e];
}

class IndikatorStateAdded extends IndikatorState {}

class IndikatorStateLoadedById extends IndikatorState {
  final IndikatorFormModel indikator;
  const IndikatorStateLoadedById(this.indikator);

  @override
  List<Object> get props => [indikator];
}

class IndikatorStateUpdated extends IndikatorState {}

class IndikatorStateDeleted extends IndikatorState {}

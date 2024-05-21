part of 'kriteria_bloc.dart';

abstract class KriteriaState extends Equatable {
  const KriteriaState();

  @override
  List<Object> get props => [];
}

class KriteriaInitial extends KriteriaState {}

class KriteriaLoading extends KriteriaState {}

class KriteriaLoaded extends KriteriaState {
  final List<KriteriaFormModel> kriteria;
  const KriteriaLoaded(this.kriteria);

  @override
  List<Object> get props => [kriteria];
}

class KriteriaFailed extends KriteriaState {
  final String e;

  const KriteriaFailed(this.e);

  @override
  List<Object> get props => [e];
}

class KriteriaSuccess extends KriteriaState {
  final List<KriteriaFormModel> kriteria;
  const KriteriaSuccess(this.kriteria);

  @override
  List<Object> get props => [kriteria];
}

class KriteriaLoadedById extends KriteriaState {
  final KriteriaFormModel kriteria;
  const KriteriaLoadedById(this.kriteria);

  @override
  List<Object> get props => [kriteria];
}

class KriteriaGetIdSuccess extends KriteriaState {
  final KriteriaFormModel kriteria;
  const KriteriaGetIdSuccess(this.kriteria);

  @override
  List<Object> get props => [kriteria];
}

class KriteriaUpdateSuccess extends KriteriaState {}

class KriteriaAddSuccess extends KriteriaState {}

class KriteriaDeleteSuccess extends KriteriaState {}

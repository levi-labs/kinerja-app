part of 'kriteria_bloc.dart';

abstract class KriteriaEvent extends Equatable {
  const KriteriaEvent();

  @override
  List<Object> get props => [];
}

class KriteriaGet extends KriteriaEvent {}

class KriteriaAdd extends KriteriaEvent {
  final KriteriaFormModel data;
  const KriteriaAdd(this.data);

  @override
  List<Object> get props => [data];
}

class KriteriaUpdate extends KriteriaEvent {
  final KriteriaFormModel data;
  const KriteriaUpdate(this.data);

  @override
  List<Object> get props => [data];
}

class KriteriaGetById extends KriteriaEvent {
  final int id;
  const KriteriaGetById(this.id);

  @override
  List<Object> get props => [id];
}

class KriteriaDelete extends KriteriaEvent {
  final int id;
  const KriteriaDelete(this.id);

  @override
  List<Object> get props => [id];
}

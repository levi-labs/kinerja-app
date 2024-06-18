part of 'skala_bloc.dart';

abstract class SkalaEvent extends Equatable {
  const SkalaEvent();

  @override
  List<Object> get props => [];
}

class SkalaEventGet extends SkalaEvent {}

class SkalaEventAdd extends SkalaEvent {
  final SkalaFormModel data;
  const SkalaEventAdd(this.data);

  @override
  List<Object> get props => [data];
}

class SkalaEventGetById extends SkalaEvent {
  final int id;
  const SkalaEventGetById(this.id);

  @override
  List<Object> get props => [id];
}

class SkalaEventUpdate extends SkalaEvent {
  final SkalaFormModel data;
  const SkalaEventUpdate(this.data);

  @override
  List<Object> get props => [data];
}

class SkalaEventDelete extends SkalaEvent {
  final int id;
  const SkalaEventDelete(this.id);

  @override
  List<Object> get props => [id];
}

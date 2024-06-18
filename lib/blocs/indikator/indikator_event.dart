part of 'indikator_bloc.dart';

abstract class IndikatorEvent extends Equatable {
  const IndikatorEvent();

  @override
  List<Object> get props => [];
}

class GetEventIndikator extends IndikatorEvent {}

class GetEventIndikatorByKriteria extends IndikatorEvent {
  final int id;
  const GetEventIndikatorByKriteria(this.id);

  @override
  List<Object> get props => [id];
}

class AddEventIndikator extends IndikatorEvent {
  final IndikatorFormModel data;
  const AddEventIndikator(this.data);

  @override
  List<Object> get props => [data];
}

class GetEventIndikatorById extends IndikatorEvent {
  final int id;
  const GetEventIndikatorById(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateEventIndikator extends IndikatorEvent {
  final IndikatorFormModel data;
  const UpdateEventIndikator(this.data);

  @override
  List<Object> get props => [data];
}

class DeleteEventIndikator extends IndikatorEvent {
  final int id;
  const DeleteEventIndikator(this.id);

  @override
  List<Object> get props => [id];
}

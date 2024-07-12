part of 'pegawai_bloc.dart';

abstract class PegawaiEvent extends Equatable {
  const PegawaiEvent();

  @override
  List<Object> get props => [];
}

class PegawaiLoadedEvent extends PegawaiEvent {}

class PegawaiCreatedEvent extends PegawaiEvent {
  final PegawaiFormModel data;
  const PegawaiCreatedEvent(this.data);

  @override
  List<Object> get props => [data];
}

class PegawaiShowByIdEvent extends PegawaiEvent {
  final int id;
  const PegawaiShowByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class PegawaiUpdatedEvent extends PegawaiEvent {
  final PegawaiFormModel data;
  const PegawaiUpdatedEvent(this.data);

  @override
  List<Object> get props => [data];
}

class PegawaiDeletedEvent extends PegawaiEvent {
  final int id;
  const PegawaiDeletedEvent(this.id);

  @override
  List<Object> get props => [id];
}

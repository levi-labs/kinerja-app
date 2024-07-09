part of 'nilai_bloc.dart';

abstract class NilaiEvent extends Equatable {
  const NilaiEvent();

  @override
  List<Object> get props => [];
}
/*
1. NilaiLoadedEvent = load list data nilai based on Tanggal Nilai
2. NilaiShowByDateEvent = load detail list data nilai based on Tanggal Nilai

*/

class NilaiLoadedEvent extends NilaiEvent {}

class NilaiCreateByDateEvent extends NilaiEvent {
  final String date;
  const NilaiCreateByDateEvent(this.date);

  @override
  List<Object> get props => [date];
}

class NilaiCreateDataEvent extends NilaiEvent {
  final String idPegawai;
  final List<int> controllerId;
  final List<int> controllerNilai;
  final String tanggalNilai;
  const NilaiCreateDataEvent(this.idPegawai, this.controllerId,
      this.controllerNilai, this.tanggalNilai);

  @override
  List<Object> get props =>
      [idPegawai, controllerId, controllerNilai, tanggalNilai];
}

class NilaiShowByDateEvent extends NilaiEvent {
  final String date;
  const NilaiShowByDateEvent(this.date);

  @override
  List<Object> get props => [date];
}

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

class NIlaiEditByIdAndDateEvent extends NilaiEvent {
  final String idPegawai;
  final String date;
  const NIlaiEditByIdAndDateEvent(this.idPegawai, this.date);

  @override
  List<Object> get props => [idPegawai, date];
}

class NilaiUpdateDataEvent extends NilaiEvent {
  final List<int> indikatorId;
  final List<int> nilaiId;
  final List<int> inputNilai;

  const NilaiUpdateDataEvent(
    this.indikatorId,
    this.nilaiId,
    this.inputNilai,
  );

  @override
  List<Object> get props => [indikatorId, nilaiId, inputNilai];
}

class NilaiDeleteByIdAndDateEvent extends NilaiEvent {
  final String idPegawai;
  final String date;
  const NilaiDeleteByIdAndDateEvent(this.idPegawai, this.date);

  @override
  List<Object> get props => [idPegawai, date];
}

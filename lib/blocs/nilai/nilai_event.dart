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

class NilaiShowByDateEvent extends NilaiEvent {
  final String date;
  const NilaiShowByDateEvent(this.date);

  @override
  List<Object> get props => [date];
}

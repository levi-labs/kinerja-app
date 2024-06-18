part of 'nilai_bloc.dart';

abstract class NilaiState extends Equatable {
  const NilaiState();

  @override
  List<Object> get props => [];
}

class NilaiInitial extends NilaiState {}

class NilaiLoadingState extends NilaiState {}

class NilaiLoadedState extends NilaiState {
  final List<NilaiFormModel> data;
  const NilaiLoadedState(this.data);

  @override
  List<Object> get props => [data];
}

class NilaiErrorState extends NilaiState {
  final String e;
  const NilaiErrorState(this.e);

  @override
  List<Object> get props => [e];
}

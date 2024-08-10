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

class NilaiShowByDateState extends NilaiState {
  // final List<NilaiFormModel> data;

  final List<NilaiCreateFormModel> data;

  const NilaiShowByDateState(this.data);

  @override
  List<Object> get props => [data];
}

class NilaiLoadedByDateState extends NilaiState {
  final List<NilaiByDate> data;
  const NilaiLoadedByDateState(this.data);

  @override
  List<Object> get props => [data];
}

class NilaiLoadedByIdPegawaiAndDateState extends NilaiState {
  final NilaiEditForm data;
  const NilaiLoadedByIdPegawaiAndDateState(this.data);

  @override
  List<Object> get props => [data];
}

class NilaiLoadedDetailState extends NilaiState {
  final List<NilaiDetailModel> data;
  const NilaiLoadedDetailState(this.data);

  @override
  List<Object> get props => [data];
}

class NilaiCreateSuccessState extends NilaiState {}

class NilaiUpdateSuccessState extends NilaiState {}

class NilaiDeleteSuccessState extends NilaiState {}

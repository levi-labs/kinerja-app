part of 'pegawai_bloc.dart';

abstract class PegawaiState extends Equatable {
  const PegawaiState();

  @override
  List<Object> get props => [];
}

//initial
//loading
//loaded data
//error

class PegawaiInitial extends PegawaiState {}

class PegawaiLoadingState extends PegawaiState {}

class PegawaiLoadedState extends PegawaiState {
  final List<PegawaiFormModel> data;
  const PegawaiLoadedState(this.data);

  @override
  List<Object> get props => [data];
}

class PegawaiGetByIdSuccessState extends PegawaiState {
  final PegawaiFormModel data;
  const PegawaiGetByIdSuccessState(this.data);

  @override
  List<Object> get props => [data];
}

class PegawaiGetDataSuccessState extends PegawaiState {}

class PegawaiCreatedSuccessState extends PegawaiState {}

class PegawaiUpdatedSuccessState extends PegawaiState {}

class PegawaiDeletedSuccessState extends PegawaiState {}

class PegawaiErrorState extends PegawaiState {
  final String error;

  const PegawaiErrorState(this.error);

  @override
  List<Object> get props => [error];
}

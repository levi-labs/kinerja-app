part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardFormModel dashboard;
  const DashboardLoaded(this.dashboard);

  @override
  List<Object> get props => [dashboard];
}

class DashboardError extends DashboardState {
  final String e;

  const DashboardError(this.e);

  @override
  List<Object> get props => [e];
}

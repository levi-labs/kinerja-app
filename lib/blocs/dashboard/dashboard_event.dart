part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardGet extends DashboardEvent {
  // final DashboardFormModel dashboard;

  // const DashboardGet(this.dashboard);

  // @override
  // List<Object> get props => [dashboard];
}

class DashboardGetForm extends DashboardEvent {}

part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class AutoLogin extends HomeEvent {}

class RequestPin extends HomeEvent {}

class QuickInsertHome extends HomeEvent {
  final ListOfItems list;
  final int timestamp;
  final String token;

  const QuickInsertHome({
    required this.list,
    required this.token,
    required this.timestamp,
  });

  @override
  List<Object> get props => [list, token, timestamp];
}

class ReportHomeError extends HomeEvent {}

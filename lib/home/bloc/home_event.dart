part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class AutoLogin extends HomeEvent {}

class RequestLogin extends HomeEvent {
  final String username;
  final String password;

  const RequestLogin({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class UpdateHome extends HomeEvent {
  final List<ListOfItems> lists;
  final String token;

  const UpdateHome({required this.lists, required this.token});

  @override
  List<Object> get props => [lists, token];
}

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

class ReportHomeError extends HomeEvent {
  final String token;

  const ReportHomeError(this.token);

  @override
  List<Object> get props => [token];
}

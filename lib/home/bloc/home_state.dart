part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeError extends HomeState {
  final String token;

  const HomeError({required this.token});

  @override
  List<Object> get props => [token];
}

class HomeLoaded extends HomeState {
  final String token;
  final List<ListOfItems> lists;

  const HomeLoaded({
    required this.lists,
    required this.token,
  });

  @override
  List<Object> get props => [lists, token];
}

class HomeLoginRequired extends HomeState {}

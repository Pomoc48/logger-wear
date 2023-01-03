part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeError extends HomeState {}

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

class HomePinRequired extends HomeState {}

class HomePinGenerated extends HomeState {
  final String pin;
  final int id;

  const HomePinGenerated({required this.id, required this.pin});

  @override
  List<Object> get props => [pin, id];
}

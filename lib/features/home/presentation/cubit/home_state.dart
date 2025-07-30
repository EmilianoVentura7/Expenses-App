part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeSuccess extends HomeState {
  final HomeEntity homeData;
  HomeSuccess(this.homeData);
}
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

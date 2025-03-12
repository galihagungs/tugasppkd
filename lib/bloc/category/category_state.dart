part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryFailed extends CategoryState {
  final String e;
  CategoryFailed(this.e);
  List<Object> get props => [e];
}

final class CategorySucces extends CategoryState {
  final List<Categorymodel> cattegory;
  CategorySucces(this.cattegory);

  List<Object> get props => [cattegory];
}

final class CategorySuccesDrowDown extends CategoryState {
  final String valueDrop;
  final List<Categorymodel> cattegory;
  CategorySuccesDrowDown(this.valueDrop, this.cattegory);

  List<Object> get props => [valueDrop, cattegory];
}

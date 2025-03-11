part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductFailed extends ProductState {
  final String e;
  ProductFailed(this.e);
  List<Object> get props => [e];
}

final class ProductSucces extends ProductState {
  // final ProductModel prod;
  final List<Map<String, dynamic>> map2;
  // ProductSucces(this.map2);
  ProductSucces(this.map2);

  List<Object> get props => [map2];
}

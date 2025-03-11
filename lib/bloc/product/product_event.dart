part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {
  const ProductEvent();
  List<Object> get props => [];
}

class ProductGetbyCat extends ProductEvent {
  // final String url;
  final String catName;
  const ProductGetbyCat(this.catName);
}

class GetProductAll extends ProductEvent {}

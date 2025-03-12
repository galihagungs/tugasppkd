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

// class GetProductAll extends ProductEvent {}

class GetProductByCategory extends ProductEvent {
  final String namaCategory;
  const GetProductByCategory(this.namaCategory);
}

class SearchProduct extends ProductEvent {
  final String searchData;
  final String namaCategory;

  const SearchProduct({required this.searchData, required this.namaCategory});
}

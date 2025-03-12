import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui_new/local/dbHelper.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  DbHelper dbhelper = DbHelper();
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetProductByCategory) {
        try {
          emit(ProductLoading());
          // final data = await dbhelper.getProduct();
          final data = await dbhelper.getProduct(
            categoryName: event.namaCategory.toString(),
          );
          emit(ProductSucces(data));
        } catch (e) {
          emit(ProductFailed(e.toString()));
        }
      } else if (event is SearchProduct) {
        try {
          emit(ProductLoading());
          final data = await dbhelper.searchProduct(
            categoryName: event.namaCategory,
            search: event.searchData,
          );
          emit(ProductSucces(data));
        } catch (e) {
          emit(ProductFailed(e.toString()));
        }
      }
    });
  }
}
